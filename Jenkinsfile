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
		stage('master') {
			when {
				expression {
                    GIT_BRANCH = 'origin/' + sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                    println GIT_BRANCH
                    return GIT_BRANCH == 'origin/master'
                }
			}
			steps {
				echo "in master"
			}
		}

		stage('all') {
			steps {
				echo "all"
			}
		}
	}
}