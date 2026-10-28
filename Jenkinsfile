pipeline {
    agent any

    environment {
        HOST_WORKSPACE = '/home/ers/workspace/ansible-barman'
    }

    stages {
        stage('Checkout no Hospedeiro') {
            steps {
                sshagent(credentials: ['ssh-ubuntu']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ers@172.17.0.1 "cd ${HOST_WORKSPACE} && git pull origin main"
                    """
                }
            }
        }

        stage('Executar Ansible Barman Deploy') {
            steps {
                sshagent(credentials: ['ssh-ubuntu']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ers@172.17.0.1 "cd ${HOST_WORKSPACE} && sudo ansible-playbook playbook.yml"
                    """
                }
            }
        }

        stage('Validar Status Barman') {
            steps {
                sshagent(credentials: ['ssh-ubuntu']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ers@172.17.0.1 "/usr/local/bin/barman check tm_pg_17_edpostgres17"
                    """
                }
            }
        }
    }
}
