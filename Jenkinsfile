pipeline {

    agent any

    environment {
    PROJECT_HOME = 'E:\\performance-onetouch-framework'
    JMETER_HOME  = 'C:\\Loadmagic\\apache-jmeter-5.6.3\\apache-jmeter-5.6.3'
    KUBECONFIG   = 'C:\\Users\\LENOVO\\.kube\\config'
	}

    stages {

        stage('Start InfluxDB') {
            steps {
                bat 'docker start influxdb'
            }
        }
	stage('Validate JMeter Scripts') {
		steps {
			bat '''
			echo =====================================
			echo Validating JMeter Test Plan...
			echo =====================================

			if not exist "%PROJECT_HOME%\\jmeter\\testplans\\RestfulBooker.jmx" (
				echo ERROR: RestfulBooker.jmx not found.
				exit /b 1
			)

			echo SUCCESS: JMeter Test Plan Found.

			dir "%PROJECT_HOME%\\jmeter\\testplans"
			'''
		}
	}
        stage('Clean Workspace') {
            steps {
                bat '''
                echo =====================================
                echo Cleaning old reports...
                echo =====================================

                if exist "%PROJECT_HOME%\\reports" (
                    rmdir /S /Q "%PROJECT_HOME%\\reports"
                )

                if exist "%PROJECT_HOME%\\results" (
                    rmdir /S /Q "%PROJECT_HOME%\\results"
                )

                mkdir "%PROJECT_HOME%\\reports"
                mkdir "%PROJECT_HOME%\\results"

                dir "%PROJECT_HOME%"
                '''
            }
        }
	stage('Verify Kubernetes') {
    steps {
        bat '''
        echo =====================================
        echo Verifying Kubernetes
        echo =====================================

        echo USERNAME=%USERNAME%
        echo USERPROFILE=%USERPROFILE%
        echo KUBECONFIG=%KUBECONFIG%

        kubectl config current-context

        kubectl get nodes

        kubectl get namespaces
        '''
		}
	}
       stage('Build Docker Image') {
    steps {
        bat '''
        echo =====================================
        echo Building Docker Image
        echo =====================================

        cd /d E:\\performance-onetouch-framework\\docker

        docker compose build
        '''
    }
}
    stage('Run Docker Container') {
    steps {
        bat '''
        echo =====================================
        echo Running Docker Container
        echo =====================================

        cd /d E:\\performance-onetouch-framework\\docker

        docker compose down

        docker compose up
        '''
    }
}
        stage('Publish HTML Report') {
            steps {
                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'E:/performance-onetouch-framework/reports',
                    reportFiles: 'index.html',
                    reportName: 'JMeter HTML Report'
                ])
            }
        }

       stage('Archive Results') {
    steps {
        bat '''
        copy "%PROJECT_HOME%\\results\\results.jtl" "%WORKSPACE%\\results.jtl"
        '''
        archiveArtifacts artifacts: 'results.jtl', fingerprint: true
    }
}

        stage('Completed') {
            steps {
                echo '=========================================='
                echo 'Performance Test Completed Successfully'
                echo '=========================================='
            }
        }
    }

    post {

        always {
            echo "Pipeline Finished"
        }

        success {
            echo "SUCCESS : Performance Test Completed."
        }

        failure {
            echo "FAILURE : Check Console Output and jmeter.log"
        }
    }
}