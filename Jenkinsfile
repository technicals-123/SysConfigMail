pipeline {
    agent any
    
    stages {
        stage('Generate CSV') {
            steps {
                script {
// Execute config.sh script to generate CSV file
sh 'sh config.sh'
                }
            }
        }
    
        
            stage('Install Python and pandas') {
                steps { 
                       sh 'apt-get update'
                       sh 'apt-get update && sudo apt-get install -y python3 python3-pip' 
                       sh 'pip3 install pandas'
                      }
            }
            
        stage('Convert to Excel') {
            steps {
                script {
                    // Use Python with pandas to convert CSV to Excel
                    sh 'sudo chmod +x convert_to_excel.sh'
                    sh './convert_to_excel.sh'
                }
            }
        }
    
       
        
        stage('Send Email') {
            steps {
                emailext subject: 'System Information Excel Report',
                          body: 'Please find the attached Excel file containing system information.',
                          to: 'sranjan@healthedge.com',
                          attachmentsPattern: 'system_info.xlsx'
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
