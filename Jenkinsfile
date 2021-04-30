pipeline {
    agent {
    docker {
        image 'nginx:alpine'
        label 'my-defined-label'
        args  '-v /tmp:/tmp'
        }
    }
    stages {
        stage('Building') {
            steps {
                echo 'Probando 3a vez en Jenkins'
            }
        }
    }
    post { 
        always { 
            echo 'Con mi cielo.'
        }
    }
}
