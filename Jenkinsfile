// pipeline {
//     agent any
 
//     stages {
//         // stage('Fetch Code') {
//         //     steps {
//         //         // Clone the repository
//         //         git 'https://github.com/technicals-123/SysConfigMail.git'
//         //     }
//         // }
//         stage('Execute Script') {
//             steps {
//                 // Make the script executable
//                 sh 'chmod +x sysconfig.sh'
//                 // Execute the script and capture output
//                 script {
//                     def scriptOutput = sh(script: './sysconfig.sh', returnStdout: true).trim()
//                     // Print script output for debugging
//                     echo "Script Output: ${scriptOutput}"
//                     // Send email notification with script output in the body
//                     emailext(
//                         to: 'sranjan@healthedge.com', // Recipient email address
//                         subject: 'Script Execution Status',
//                         body: "${scriptOutput}", // Include script output in email body
//                         mimeType: 'text/plain'
//                     )
//                 }
//             }
//         }
// stage('SonarQube Analysis') {
//     steps { 
//         script {
//             withSonarQubeEnv('SonarQube') {
//                 sh ''' 
//                 sonar-scanner 
//                 -Dsonar.projectKey=sonarcube_sys_analysis 
//                 -Dsonar.sources=. 
//                 -Dsonar.host.url=http://10.12.120.116:9000
//                 -Dsonar.login=sqp_4bef27d161f158d6cc7b30156b11398ab1771cee
               
//                 ''' } 
//         } 
//     }
// }
//     }
// }
//new jenkins file


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
        
        // stage('SonarQube Analysis') {
        //     steps {
        //         withSonarQubeEnv('SonarQube') {
        //             sh 'sonar-scanner'
        //         }
        //     }
        // }
        
        stage('Send Email') {
            steps {
                emailext subject: 'System Information Excel Report',
                          body: 'Please find the attached Excel file containing system information.',
                          to: 'sranjan@healthedge.com.com',
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
