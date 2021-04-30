pipeline {
    agent any
    stages {
        stage('Building') {
            steps {
                echo 'Testing'
            }
        }
    }
    post { 
        always { 
            echo 'Validating again with http url '
        }
    }
}
