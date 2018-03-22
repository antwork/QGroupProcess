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
			environment { 
                username = credentials('coremail_developer_username')
                password = credentials('coremail_developer_password')
            }
			steps {
				echo "======= Begin Build ========"
				sh 'cd QOperationGroupsDemo'
				sh 'xcodebuild -project QOperationGroupsDemo.xcodeproj -scheme QOperationGroupsDemo archive -archivePath build/QOperationGroupsDemo.xcarchive -configuration Release'

				sh 'mkdir ipa_folder'

				sh 'xcodebuild -exportArchive -exportOptionsPlist ../CI/ExportOptions.plist -archivePath build/QOperationGroupsDemo.xcarchive -exportPath ipa_folder'
				sh 'mv ipa_folder/QOperationGroupsDemo.ipa ../build/QOperationGroupsDemo.ipa'
				sh 'rm -rf ipa_folder'

				sh '/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool --upload-app -f ../build/QOperationGroupsDemo.ipa -t ios -u ${username} -p ${password}'

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