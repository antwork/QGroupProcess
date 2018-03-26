pipeline {
	agent any
	stages {
		when {
            expression { BRANCH_NAME == /(master|developer|release)/ }
		}
		stage('test') {
			echo "test master/developer/release"
		}
	}

	stages {
		when {
            branch 'master'
		}
		stage('master') {
			echo "master"
		}
	}

	stages {
		when {
            branch 'developer'
		}
		stage('developer') {
			echo "developer"
		}
	}

	stages {
		when {
            branch 'release'
		}
		stage('release') {
			echo "release"
		}
	}

	stages {
		stage('all') {
			echo "all"
		}
	}
}