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
                // Make the script executable
sh 'chmod +x sysconfig.sh'
                // Execute the script and capture output
def scriptOutput = sh(script: './sysconfig.sh', returnStdout: true).trim()
                // Print script output for debugging
                echo "Script Output: ${scriptOutput}"
            }
        }
    }
 
    post {
        always {
            // Send email notification with script output in the body
            emailext(
                to: 'sranjan@healthedge.com', // Recipient email address
                subject: 'Script Execution Status',
                body: "${scriptOutput}", // Include script output in email body
                mimeType: 'text/plain'
            )
        }
    }
}
