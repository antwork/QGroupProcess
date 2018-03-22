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
				xcodebuild clean 
				 -project QGroupProcess.xcodeproj \
				 -scheme QGroupProcess \
				 -destination 'platform=iOS Simulator,name=iPhone 6,OS=11.2' \
				 test | xcpretty -t; test ${PIPESTATUS[0]} -eq 0
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