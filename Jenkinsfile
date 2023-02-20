pipeline {
    agent { label 'linux'}
    options {
        skipDefaultCheckout(true)
    }

    parameters {
        string(name:'TEST_TF_SPACE', defaultValue:'default', description:'terraform workspace')
        string(name:'TEST_RS_PATH', defaultValue:'virtualnetwork', description:'terraform workspace')
    }

    stages {
        stage('clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('checkout') {
            steps {
                checkout scm
            }
        }
        stage('terraform') {
            environment { //拉取微软的远端存储密钥
                ARM_ACCESS_CREDS = credentials('azurestoragekey') 
                TF_SPACE = "$params.TEST_TF_SPACE"
                RS_PATH = "$params.TEST_RS_PATH"
            }

            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: "testAws",
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh 'export ARM_ACCESS_KEY=$ARM_ACCESS_CREDS_PSW'     
                    sh 'chmod +x ./$RS_PATH/terraformmw'
                    sh './$RS_PATH/terraformmw'
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    } 
}
