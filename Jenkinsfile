pipeline {
  agent any
  stages {
    stage('Primero') {
      parallel {
        stage('Primero') {
          steps {
            sh 'echo "****** Primero stage *******"'
          }
        }
        stage('error') {
          steps {
            echo 'Mensaje de Abajo'
          }
        }
      }
    }
    stage('Segundo') {
      parallel {
        stage('Segundo') {
          steps {
            echo 'Segundo mensaje'
          }
        }
        stage('') {
          steps {
            echo 'step under second'
          }
        }
      }
    }
  }
}