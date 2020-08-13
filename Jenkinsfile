
pipeline {
    agent { dockerfile true }
    tools {
        maven 'm3'
    }
	def app
	def dockerfile = 'Dockerfile'
	
	/* Checking that repository cloned to workspace */
    stages {
        stage('Clone repository') {
            steps {
                checkout scm 
            }
        }
	/* Building image */	
        stage ('build') {
            steps {
			    app = docker.build("helloboxfuse:${env.BUILD_ID}", "-f ${dockerfile}")
            }
        }
	/* Deploy step */
        stage ('deploy') {
            steps {
                deploy adapters: [tomcat8(credentialsId: '09e713a2-f1b9-4542-8654-8809f6c2666b', path: '', url: 'http://84.201.177.210:8080/')], contextPath: 'mywebapp1', war: '**/*.war'
            }
        }
    }
	/* Push the image to the Docker Hub Registry */
	
    node {
	
       docker.withRegistry ('https://registry.hub.docker.com', 'docker-hub-credentials'){
			app.inside {
              app.push ("${env.BUILD_NUMBER}","latest")
			}
        }
		
	stages  {
      agent any
		steps { 
	       sh 'docker build -t app:latest .'	
	       sh 'docker run -d -p 8080:8080 app'
		   }
    }
	
}    