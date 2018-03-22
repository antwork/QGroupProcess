pipeline {
	agent any
	stages {
		stage('Build') {
			steps {
				echo "build"
			}
		}

		stage('Test') {
			steps {
				echo "begin test"
				sh """
				set -o pipefail && xcodebuild clean 
				 -project QGroupProcess.xcodeproj \
				 -scheme QGroupProcess \
				 -destination 'platform=iOS Simulator,name=iPhone 6,OS=11.2' \
				 test | xcpretty
				"""
				echo "end test"
			}
		}

		stage('Deploy') {
			steps {
				echo "Deploy"
			}
		}
	}
}