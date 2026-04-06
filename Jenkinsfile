pipeline {
    agent any

    options {
        timestamps()
    }

    parameters {
        string(name: 'DEPLOY_HOST', defaultValue: '', description: 'Azure VM public IP or DNS name')
        string(name: 'DEPLOY_USER', defaultValue: 'azureuser', description: 'SSH username on the Azure VM')
        string(name: 'DEPLOY_PATH', defaultValue: '/var/www/tournament-scheduler', description: 'Target directory on the Azure VM')
        string(name: 'SSH_PORT', defaultValue: '22', description: 'SSH port on the Azure VM')
    }

    environment {
        SSH_CREDENTIAL_ID = 'azure-vm-ssh-key'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Prepare Scripts') {
            steps {
                sh 'chmod +x scripts/build.sh scripts/deploy.sh'
            }
        }

        stage('Build') {
            steps {
                sh './scripts/build.sh'
            }
        }

        stage('Deploy') {
            steps {
                script {
                    if (!params.DEPLOY_HOST?.trim()) {
                        error('DEPLOY_HOST is required')
                    }
                }

                sshagent(credentials: [env.SSH_CREDENTIAL_ID]) {
                    sh './scripts/deploy.sh dist'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'dist/**', fingerprint: true, allowEmptyArchive: true
        }
    }
}