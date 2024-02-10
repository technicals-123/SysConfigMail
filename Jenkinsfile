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
        
        stage('Convert to Excel') {
            steps {
                script {
                    // Use Python with pandas to convert CSV to Excel
                    sh '''
                        python3 - <<EOF
                        import pandas as pd
                        df = pd.read_csv('system_info.csv')
                        df.to_excel('system_info.xlsx', index=False)
                        EOF
                    '''
                }
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
