pipeline {
	agent any

	environment {
		BRANCH_NAME = '${env.BUILD_NUMBER}'
	}

	stages {
		stage('test') {
			when {
	            expression { BRANCH_NAME == /(master|developer|release)/ }
			}
			steps {
				echo "test master/developer/release"
			}
		}

		stage('master') {
			steps {
				echo "master"
			}
		}

		stage('developer') {
			when {
	            branch 'developer'
			}
			steps {
				echo "developer"
			}
		}

		stage('release') {
			when {
	            branch 'release'
			}
			steps {
				echo "release"
			}
		}

		stage('all') {
			steps {
				echo "all"
				echo "${env.BRANCH_NAME}"
				echo BRANCH_NAME
			}
		}
	}
}