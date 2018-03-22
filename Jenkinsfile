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

				sh 'xcodebuild clean -project QGroupProcess.xcodeproj -scheme QGroupProcess -configuration "Debug" -destination "platform=iOS Simulator,name=iPhone 6,OS=11.2" test -enableCodeCoverage YES | /usr/local/bin/xcpretty -r junit'
				
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