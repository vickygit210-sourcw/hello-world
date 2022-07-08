pipeline {
    agent any
    environment {
        PATH = "/opt/maven:/opt/maven/bin:/usr/lib/jvm/java-11-openjdk-11.0.13.0.8-1.amzn2.0.3.x86_64:${env.PATH}"
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
                dir("hello_world") {
                    sh "mvn test"
                }
            }
        }
    }
}
