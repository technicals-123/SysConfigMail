pipeline {
    agent any
    
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
}
    
    // post {
    //     always {
    //         cleanup {
    //             script {
    //                 // Clean up generated files
    //                 sh 'rm system_info.csv system_info.xlsx'
    //             }
    //         }
    //     }
    // }
}
