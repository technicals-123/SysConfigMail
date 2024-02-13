pipeline {
    agent any
    // environment{
    //     SONAR_SCANNER_HOME= tool 'SonnarScanner'
    // }
    
    stages {
        stage('Generate Excel file') {
            steps {
                script {
                      // Execute config.sh script to generate CSV file
                         sh 'chmod +x config.sh'
                         sh 'sh config.sh'
                }
            }
        }
  
        stage('Send Email') {
            steps {
             
                   script {
                    def scriptOutput = sh(script: './config.sh', returnStdout: true).trim()
                    //Print script output for debugging
                    echo "Script Output: ${scriptOutput}"
                    // Send email notification with script output in the body
                    emailext(
                        to: 'sranjan@healthedge.com', // Recipient email address
                        subject: 'User System Configurations Details',
                        body: "${scriptOutput}", // Include script output in email body
                        attachmentsPattern: '**/UserData.xlsx'
                    )
                }
            }
        }
// stage('Print SonarScanner Home') { steps { script { println "SonarScanner home: ${SONAR_SCANNER_HOME}" } } }

           // stage('SonarQube Analysis') {
    // steps { 
    //     script {
    //         withSonarQubeEnv('SonarQube') {
    //             sh ''' 
    //              ${SONAR_SCANNER_HOME}/bin/sonar-scanner\
    //             -Dsonar.projectKey=sonarcube_sys_analysis \
    //             -Dsonar.sources=. \
    //             -Dsonar.host.url=http://10.12.120.116:9000 \
    //             -Dsonar.login=sqp_4bef27d161f158d6cc7b30156b11398ab1771cee
               
    //             ''' } 
    //     } 
    // }
// }
}
    

}
