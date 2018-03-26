pipeline {
	agent any
	stages {
		when {
            expression { BRANCH_NAME == /(master|developer|release)/ }
		}
		stage('test') {
			steps {
				echo "test master/developer/release"
			}
		}
	}

	stages {
		when {
            branch 'master'
		}
		stage('master') {
			steps {
				echo "master"
			}
		}
	}

	stages {
		when {
            branch 'developer'
		}
		stage('developer') {
			steps {
				echo "developer"
			}
		}
	}

	stages {
		when {
            branch 'release'
		}
		stage('release') {
			steps {
				echo "release"
			}
		}
	}

	stages {
		stage('all') {
			steps {
				echo "all"
			}
		}
	}
}