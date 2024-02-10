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
                    script { 
                        // Check if Python is installed 
                        def pythonInstalled = sh(script: 'python3 --version', returnStatus: true) == 0 
                        if (!pythonInstalled) { 
                            // Install Python 
                            sh 'sudo apt-get update && sudo apt-get install -y python3' } 
                        // Check if pandas is installed 
                        def pandasInstalled = sh(script: 'python3 -c "import pandas"', returnStatus: true) == 0 
                        if (!pandasInstalled) {
                            // Install pandas sh 'pip3 install pandas' 
                        } 
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

                        #read csv file
                        df=pd.read_csv('system_info.cv')

                        #convert to excel and save
                        with pd.ExcelWriter('system_info.xlsx')
                             df.to_excel(writer, index=False, sheet_name='Sheet1')
                        EOF
                        
                    '''
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
