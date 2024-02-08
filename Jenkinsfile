pipeline {
    agent any
 
    stages {
        stage('Fetch Code') {
            steps {
                // Clone the repository
                git 'https://github.com/yourusername/your-repo.git'
            }
        }
        stage('Execute Script') {
            steps {
                // Execute the shell script
                sh 'bash your_script.sh'
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
