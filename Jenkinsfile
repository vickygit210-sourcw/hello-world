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
                sh "git clone -b tfiacfeature https://github.com/vickygit210-sourcw/hello-world.git"
                sh "cp -R ./hello-world/terraform/* ~/terraform"
            }
        }
        stage("Build war package"){
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

        stage("Build Container Image"){
            steps {
                dir("hello-world"){
                    ansiblePlaybook (playbook: 'containercreate.yml')
                }
            }
        }
        stage("Build Dockerhost"){
            steps {
                dir("/var/lib/jenkins/terraform/Env") {
                    sh "terraform init"
                    sh "terraform apply -auto-approve"
                }
            }
        }
        stage("Deploy Container Image"){
            steps {
                dir("hello-world") {
                    ansiblePlaybook credentialsId: 'jenkinspoc', disableHostKeyChecking: true, installation: 'Ansible', playbook: './containerdeploy.yml'
                }
            }
        }
    }
}
