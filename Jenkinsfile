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
                    // Read CSV into DataFrame
                    def df = readFile 'system_info.csv'.trim()
                            .split('\n')
                            .collect { line -> line.split(',').collect { it.trim() } }
                            .collect { line -> line.join('\t') }
                            .join('\n')
 
                    // Write DataFrame to Excel
                    writeFile file: 'system_info.xlsx', text: df
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
    
    post {
        always {
            cleanup {
                script {
                    // Clean up generated files
                    sh 'rm system_info.csv system_info.xlsx'
                }
            }
        }
    }
}
