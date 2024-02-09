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
        // script {
        //     // Define the SonarQube Scanner tool installation
        //     def scannerHome = tool name: 'SonarQube Scanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        //     // Add SonarQube Scanner to PATH
        //     env.PATH = "${scannerHome}/bin:${env.PATH}"
        // }
        // Run SonarQube analysis
        withSonarQubeEnv('SonarQube') {
            sh 'sonar-scanner'
        }
    }
}
    }
}
