node {
	
	stage("startup") {
		//Remove later.... sho that Jenkinsfile works
		echo "start build"
		env.PATH = "/usr/local/bin/:${env.PATH}"
		env.TF_LOG = "INFO" //TRACE, DEBUG, INFO, WARN or ERROR 
		env.AWS_DEFAULT_REGION = "eu-central-1"
		
		//set AWS Credentials - credentials need to be in Jenkins credentials using a naming schema
		withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: "demo-tenant",
				      usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
			env.AWS_ACCESS_KEY_ID = "$USERNAME"
			env.AWS_SECRET_ACCESS_KEY = "$PASSWORD"
		}
		
		//Terraform version print
		sh "terraform --version -no-color"
	}
	stage("prepare") {
		
			//Checkout current project .. other can be checked out using git
			checkout scm
		
			//setup local environment with terraform init and set remote config
			// terraform init is safe to run multiple times
			
			//Attention: These Credentials are different from the ones used to deploy
			// this set is used for the state only!
			withCredentials([usernamePassword(credentialsId: 's3remotestate', usernameVariable : 'REMOTESTATE_USERNAME', passwordVariable : 'REMOTESTATE_PASSWORD')]) {
				sh """terraform init -no-color -backend=true \
				-backend-config "bucket=terraform-state-demotenant" \
				-backend-config "key=${env.JOB_NAME}" \
				-backend-config "region=eu-central-1" \
				-backend-config "access_key=$REMOTESTATE_USERNAME" \
				-backend-config "secret_key=$REMOTESTATE_PASSWORD" \
				"""
			}		
	}
	stage("plan") {
		//Run terraform plan to see what will change
		// OPTIONAL set vars using --var-file=[JOB_NAME].tfvars
		// e.g have the vars in the tenant project and apply them to the code to run the setup for this tenant
		sh "terraform plan -no-color -out=plan.out"
	}
	stage("apply") {
		input 'Do you want to apply the Terraform plan?'
		//Run terraform plan to see what will change
		sh "terraform apply plan.out -no-color"
		
		//Write result somewhere
	}
}
