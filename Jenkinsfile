pipeline {
    agent any
    environment {
        PATH = "/opt/maven:/opt/maven/bin:${env.PATH}"
    }
    stages {
        stage("Clean Up"){
            steps {
                deleteDir()
            }
        }
        stage("Clone Repo"){
            steps {
                sh "git clone https://github.com/vickygit210-sourcw/hello-world.git"
            }
        }
        stage("Build"){
            steps {
                dir("hello-world") {
                    sh "mvn clean install"
                }
            }
        }
        stage("Test"){
            steps {
                dir("hello-world") {
                    sh "mvn test"
                }
            }
        }
    }
}
