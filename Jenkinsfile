pipeline {
	agent any
	stages {
		stage('test') {
			when {
	            expression { env.BRANCH_NAME == /(master|developer|release)/ }
			}
			steps {
				echo "test master/developer/release"
			}
		}

		stage('master') {
			when {
	            branch 'master'
			}
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
			}
		}
	}
}