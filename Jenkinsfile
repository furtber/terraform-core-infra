node {
	
	stage("startup") {
		//Remove later.... sho that Jenkinsfile works
		echo "start build"
		env.PATH = "/usr/local/bin/:${env.PATH}"
		env.TF_LOG = "INFO" //TRACE, DEBUG, INFO, WARN or ERROR 

                //Select AWS profile which has been configured in /var/lib/jenkins/.aws/config
                sh "echo Provisioning to environment: $ENVIRONMENT"
                env.AWS_DEFAULT_PROFILE = "$ENVIRONMENT"
		
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
		sh """terraform init -no-color -backend=true \
			-backend-config "bucket=PLACEHOLDER" \
			-backend-config "key=${env.JOB_NAME}" \
			-backend-config "region=eu-west-1" \
		"""
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
