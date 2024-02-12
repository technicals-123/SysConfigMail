pipeline {
    agent any
    environment{
        SONAR_SCANNER_HOME= tool 'SonnarScanner'
    }
    
    stages {
        stage('Generate CSV') {
            steps {
                script {
                      // Execute config.sh script to generate CSV file
                         sh 'chmod +x config.sh'
                         sh 'sh config.sh'
                }
            }
        }
    
        
            // stage('Install Python and pandas') {
            //     steps { 
            //            sh 'sudo yum update -y'
            //            sh 'sudo yum install -y python3 python3-pip' 
            //            sh 'pip3 install pandas'
            //           }
            // }
            
        // stage('Convert to Excel') {
        //     steps {
        //         script {
        //             // Use Python with pandas to convert CSV to Excel
        //             sh 'chmod +x convert_to_excel.sh'
        //             sh './convert_to_excel.sh'
        //         }
        //     }
        // }
    
       
        
        stage('Send Email') {
            steps {
                // emailext subject: 'System Information Excel Report',
                //           body: 'Please find the attached Excel file containing system information.',
                //           to: 'sranjan@healthedge.com',
                //           attachmentsPattern: 'system_info.xlsx'
                   script {
                    def scriptOutput = sh(script: './config.sh', returnStdout: true).trim()
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
        script {
            withSonarQubeEnv('SonarQube') {
                sh ''' 
                 ${SONAR_SCANNER_HOME}/bin/sonar-scanner\
                -Dsonar.projectKey=sonarcube_sys_analysis \
                -Dsonar.sources=. \
                -Dsonar.host.url=http://10.12.120.116:9000 \
                -Dsonar.login=sqp_4bef27d161f158d6cc7b30156b11398ab1771cee
               
                ''' } 
        } 
    }
}
}
    

}
