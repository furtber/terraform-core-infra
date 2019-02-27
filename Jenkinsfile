node {
	
	stage("startup") {
		//Remove later.... sho that Jenkinsfile works
		echo "Starting terraform pipeline..."
		env.PATH = "/usr/local/bin/:${env.PATH}"
		env.TF_LOG = "INFO" //TRACE, DEBUG, INFO, WARN or ERROR 

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
		sh "terraform init -no-color -backend=true"

                //Select correct environment and corresponding AWS account
                sh "terraform workspace new $ENVIRONMENT"
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
