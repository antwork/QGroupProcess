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
		stage('analyse') {
			when {
				expression {
					GIT_BRANCH = "${env.GIT_LOCAL_BRANCH}"
					print GIT_BRANCH
					return GIT_BRANCH == 'developer'
				}
			}
			steps {
				echo 'analyse only in developer'
			}
		}

		stage('unit test') {
			steps {
				echo 'all need unit test'
			}
		}

		stage('deploy') {
			when {
				expression {
					GIT_BRANCH = "${env.GIT_LOCAL_BRANCH}"
					return GIT_BRANCH == 'release' || GIT_BRANCH == 'master'
				}
			}
			steps {
				echo "release/master only"
			}
		}
	}
}