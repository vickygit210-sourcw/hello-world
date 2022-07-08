pipeline {
    agent any
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
                dir("hello_world") {
                    sh "mvn clean install"
                }
            }
        }
        stage("Test"){
            steps {
                dir("hello_world") {
                    sh "mvn test"
                }
            }
        }
    }
}
