pipeline {
	agent any

	environment {
		BRANCH_NAME = '${env.GIT_BRANCH}'
	}

	stages {
		stage('test') {
			when {
	            expression { BRANCH_NAME == /(origin\/master|origin\/developer|origin\/release)/ }
			}
			steps {
				echo "test master/developer/release"
			}
		}

		stage('master') {
			steps {
				echo "master"

				when {
		            branch 'origin/developer'
				}
				steps {
					echo "developer"
				}
			}
		}

		stage('developer') {
			when {
	            branch 'origin/developer'
			}
			steps {
				echo "developer"
			}
		}

		stage('release') {
			when {
	            branch 'origin/release'
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