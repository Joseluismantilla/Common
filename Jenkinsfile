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
        stage('') {
          steps {
            echo 'Mensaje de Abajo'
          }
        }
      }
    }
  }
}