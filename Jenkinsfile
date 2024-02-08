pipeline {
    agent any
 
    stages {
        stage('Fetch Code') {
            steps {
                // Clone the repository
                git 'https://github.com/technicals-123/SysConfigMail.git'
            }
        }
        stage('Execute Script') {
            steps {
                // Execute the shell script
                sh 'chmod +x sysconfig.sh'
                sh './sysconfig.sh'
            }
        }
    }
 
    post {
        always {
            // Send email notification
            emailext(
                to: 'sranjan@healthedge.com', // Recipient email address
                subject: 'Script Execution Status',
                body: 'The script execution has completed.',
                mimeType: 'text/plain'
            )
        }
    }
}
