pipeline {
	agent any
	stages {
		
		stage('analyse') {
			steps {
				sh 'set -o pipefail && xcodebuild clean -project QGroupProcess.xcodeproj -scheme QGroupProcess -configuration "Debug" -destination "platform=iOS Simulator,name=iPhone 6,OS=11.2" | tee xcodebuild.log | /usr/local/bin/xcpretty -r json-compilation-database -o compile_commands.json'
				sh 'oclint-json-compilation-database -e Pods\
				-v \
				-- \
				-max-priority-1 10000 \
				-max-priority-2 10000 \
				-max-priority-3 10000 \
				-report-type pmd \
				-o build/report.xml'
			}
		}

		stage('Test') {
			steps {
				sh 'set -o pipefail && xcodebuild clean -project QGroupProcess.xcodeproj -scheme QGroupProcess -configuration "Debug" -destination "platform=iOS Simulator,name=iPhone 6,OS=11.2" test -enableCodeCoverage YES | tee xcodebuild.log | /usr/local/bin/xcpretty -r json-compilation-database'
			}
		}

		stage('Build') {
			steps {
				sh 'set -o pipefail && xcodebuild -project QOperationGroupsDemo/QOperationGroupsDemo.xcodeproj -scheme QOperationGroupsDemo archive -archivePath build/QOperationGroupsDemo.xcarchive -configuration Release'
			}
		}

		stage('Deploy') {
			environment { 
                username = credentials('coremail_developer_username')
                password = credentials('coremail_developer_password')
            }
			steps {
				echo "Deploy"
				// sh 'rm -rf ipa_folder'
				// sh 'mkdir ipa_folder'

				// sh 'xcodebuild -exportArchive -exportOptionsPlist CI/ExportOptions.plist -archivePath build/QOperationGroupsDemo.xcarchive -exportPath ipa_folder'
				// sh 'mv ipa_folder/QOperationGroupsDemo.ipa build/QOperationGroupsDemo.ipa'
				// sh 'rm -rf ipa_folder'

				// sh '/Applications/Xcode.app/Contents/Applications/Application\\ Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool --validate-app -f build/QOperationGroupsDemo.ipa -t ios -u ${username} -p ${password}'

				// sh '/Applications/Xcode.app/Contents/Applications/Application\\ Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool --upload-app -f build/QOperationGroupsDemo.ipa -t ios -u ${username} -p ${password}'
			}
		}
	}

	post {
		success {
			echo "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
		}

		failure {
			echo "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
		}
	}
}