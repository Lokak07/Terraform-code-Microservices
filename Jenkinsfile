pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        region = "us-east-1"
        TF_TOKEN = credentials('TF_token')
    }
    
    stages {
        stage('Configure Terraform') {
            steps {
                script {
                    // Write AWS credentials to Terraform CLI configuration file
                    sh """
                    mkdir -p /var/lib/jenkins/.terraform.d/
                    cat <<EOF > /var/lib/jenkins/.terraform.d/credentials.tfrc.json
                    {
                      "credentials": {
                        "app.terraform.io": {
                          "token": "${TF_TOKEN}"
                        },
                        "aws": {
                          "access_key": "${AWS_ACCESS_KEY_ID}",
                          "secret_key": "${AWS_SECRET_ACCESS_KEY}"
                        }
                      }
                    }
                    EOF
                    """
                }
            }
        }
        
        stage('checkout git') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Lokak07/Terraform-code-Microservices.git']])
            }
        }
        
        stage('Terraform') {
            steps {
                script {
                    dir('eks-micro') {
                        try {
                            sh 'terraform init'
                        } catch (Exception e) {
                            if (e.toString().contains("Backend configuration changed")) {
                                sh 'terraform init -migrate-state'
                            } else {
                                throw e
                            }
                        }
                    }
                }
            }
        }
        
        stage('Formatting Terraform Code') {
            steps {
                script {
                    dir('eks-micro') {
                        sh 'terraform fmt'
                    }
                }
            }
        }
        
        stage('Validating Terraform') {
            steps {
                script {
                    dir('eks-micro') {
                        sh 'terraform validate'
                    }
                }
            }
        }
        
        stage('Previewing the Infra using Terraform') {
            steps {
                script {
                    dir('eks-micro') {
                        sh 'terraform plan'
                    }
                }
                
            }
        }
        
        stage('Manual Approval for Terraform Apply') {
            steps {
                input "Do you want to proceed with Terraform apply?"
            }
        }
        
        stage('Applying Terraform Changes') {
            steps {
                script {
                    dir('eks-micro') {
                        def terraformApplyOutput = sh(script: 'terraform apply --auto-approve', returnStdout: true).trim()
                        echo "Terraform apply completed. Output: ${terraformApplyOutput}"
                        def terraformRunLink = terraformApplyOutput =~ /https:\/\/app\.terraform\.io\/app\/\w+\/\w+\/runs\/\w+/
                        if (terraformRunLink.size() > 0) {
                            echo "Terraform apply link: ${terraformRunLink[0]}"
                        } else {
                            echo "Unable to find Terraform apply link."
                        }
                    }
                }
            }
        }
        
        stage('Deploying Application') {
            steps{
                script{
                    dir('microservices/microservices-demo-main/release') {
                        sh 'aws eks update-kubeconfig --name my-cluster'
                        sh 'kubectl apply -f kubernetes-manifests.yaml'
                    }
                }
            }
        }

    }
}
