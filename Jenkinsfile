pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: 'https://github.com/Lakshm777/lab_final.git']]])
            }
        }

        stage('Build') {
            steps {
                script {
                    echo 'Building Python application...'
                    // Optional: install dependencies if you have requirements.txt
                    bat 'C:/Users/laksh/AppData/Local/Programs/Python/Python314/python.exe -m pip install -r requirements.txt || echo "No requirements.txt found"'

                    // Run syntax check to ensure no syntax errors
                    bat 'C:/Users/laksh/AppData/Local/Programs/Python/Python314/python.exe -m py_compile app.py'

                    // Optional: short background run (non-blocking)
                    bat 'start /B C:/Users/laksh/AppData/Local/Programs/Python/Python314/python.exe app.py'
                    echo 'Build stage completed successfully!'
                }
            }
        }

        stage('Docker Deploy') {
            steps {
                script {
                    echo 'Checking for existing container...'

                    def containerExists = bat(
                        script: 'docker ps -a --format "{{.Names}}" | findstr /C:"myapp_container11"',
                        returnStatus: true
                    )

                    if (containerExists == 0) {
                        def isRunning = bat(
                            script: 'docker ps --format "{{.Names}}" | findstr /C:"myapp_container11"',
                            returnStatus: true
                        )

                        if (isRunning == 0) {
                            echo 'Container is already running. Skipping deployment.'
                        } else {
                            echo 'Container exists but stopped. Starting it...'
                            bat 'docker start myapp_container11'
                        }

                    } else {
                        echo 'Container does not exist. Building and running new one...'
                        bat 'docker build -t myapp:latest .'
                        bat 'docker run -d --name myapp_container11 -p 5000:5000 myapp:latest'
                    }

                    echo 'Docker deployment stage completed!'
                }
            }
        }
    }
}
