pipeline {
	agent any
	stages {
		
		stage('Test') {
			steps {
				echo "begin test"

				sh 'xcodebuild clean -project QGroupProcess.xcodeproj -scheme QGroupProcess -configuration "Debug" -destination "platform=iOS Simulator,name=iPhone 6,OS=11.2" test -enableCodeCoverage YES | /usr/local/bin/xcpretty -r junit'
				
				echo "end test"
			}
		}

		stage('Build') {
			steps {
				echo "======= Begin Build ========"
				cd QOperationGroupsDemo
				sh 'xcodebuild -project QOperationGroupsDemo.xcodeproj -scheme QOperationGroupsDemo archive -archivePath build/QOperationGroupsDemo.xcarchive -configuration Release'

				sh 'mkdir ipa_folder'

				sh 'xcodebuild -exportArchive -exportOptionsPlist ../CI/ExportOptions.plist -archivePath build/QOperationGroupsDemo.xcarchive -exportPath ipa_folder'
				sh 'mv ipa_folder/QOperationGroupsDemo.ipa ../build/QOperationGroupsDemo.ipa'
				sh 'rm -rf ipa_folder'
				
				echo "======= End Build ========"
			}
		}

		stage('Deploy') {
			steps {
				echo "Deploy"
			}
		}
	}
}