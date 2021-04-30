pipeline {
    agent any
    stages {
        stage('Building') {
            steps {
                echo 'Hello World'
            }
        }
    }
    post { 
        always { 
            echo 'Validating again directly.'
        }
    }
}
