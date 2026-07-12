pipeline {

    agent any

    environment {
        PROJECT_HOME = 'E:\\performance-onetouch-framework'
        JMETER_HOME  = 'C:\\Loadmagic\\apache-jmeter-5.6.3\\apache-jmeter-5.6.3'
    }

    stages {

        stage('Start InfluxDB') {
            steps {
                bat 'docker start influxdb'
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

        stage('Run JMeter') {
            steps {
                bat '''
                echo =====================================
                echo JAVA VERSION
                echo =====================================
                java -version

                echo.
                echo =====================================
                echo STARTING JMETER TEST
                echo =====================================

                call "%JMETER_HOME%\\bin\\jmeter.bat" ^
                -n ^
                -t "%PROJECT_HOME%\\jmeter\\testplans\\RestfulBooker.jmx" ^
                -q "%PROJECT_HOME%\\config\\DEV.properties" ^
                -l "%PROJECT_HOME%\\results\\results.jtl" ^
                -e ^
                -o "%PROJECT_HOME%\\reports"

                echo.
                echo =====================================
                echo JMETER EXIT CODE = %ERRORLEVEL%
                echo =====================================

                if %ERRORLEVEL% NEQ 0 (
                    echo JMeter execution failed.
                    exit /b %ERRORLEVEL%
                )

                echo.
                echo =====================================
                echo VERIFYING RESULTS
                echo =====================================

                dir "%PROJECT_HOME%\\results"
                dir "%PROJECT_HOME%\\reports"

                if not exist "%PROJECT_HOME%\\results\\results.jtl" (
                    echo ERROR: results.jtl was not generated.
                    exit /b 1
                )

                if not exist "%PROJECT_HOME%\\reports\\index.html" (
                    echo ERROR: HTML Report was not generated.
                    exit /b 1
                )

                echo.
                echo JMeter execution completed successfully.
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