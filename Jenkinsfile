pipeline {
    agent any
    stages {
        stage('Building') {
            steps {
                echo 'Probando'
            }
        }
    }
    post { 
        always { 
            echo 'Validating again with http url '
        }
    }
}
