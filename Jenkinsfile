pipeline {
    agent any
 
    stages {
        // stage('Fetch Code') {
        //     steps {
        //         // Clone the repository
        //         git 'https://github.com/technicals-123/SysConfigMail.git'
        //     }
        // }
        stage('Execute Script') {
            steps {
                // Make the script executable
                sh 'chmod +x sysconfig.sh'
                // Execute the script and capture output
                script {
                    def scriptOutput = sh(script: './sysconfig.sh', returnStdout: true).trim()
                    // Print script output for debugging
                    echo "Script Output: ${scriptOutput}"
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
stage('SonarQube Analysis') {
    steps { 
        sh ''' 
        sonar-scanner \ 
        -Dsonar.projectKey=sonarcube_sys_analysis \ 
        -Dsonar.sources=. \
        -Dsonar.host.url=http://10.12.120.116:9000 \ 
        -Dsonar.login=sqp_4bef27d161f158d6cc7b30156b11398ab1771cee 
        '''
    }
}
    }
}
