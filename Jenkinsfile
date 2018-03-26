pipeline {
	agent any

	stages {
		stage('test') {
			steps {
				echo "${env.GIT_LOCAL_BRANCH}"
				echo "${env.GIT_BRANCH}"
				echo "${env}"
			}
		}
	}
}