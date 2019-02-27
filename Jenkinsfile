node {
	
	stage("startup") {
		//Remove later.... sho that Jenkinsfile works
		echo "Starting terraform pipeline..."
		env.PATH = "/usr/local/bin/:${env.PATH}"
		env.TF_LOG = "ERROR" //TRACE, DEBUG, INFO, WARN or ERROR

                //Make selected environment available inside terraform with var.ENVIRONMENT 
                env.TF_VAR_ENVIRONMENT = "$ENVIRONMENT"

		//Terraform version print
		sh "terraform --version -no-color"
	}
	stage("prepare") {
		
		//Checkout current project .. other can be checked out using git
		checkout scm
		
		//Remove .terraform folder in case Jenkins is not configured to clear workspace
                sh "rm -rf ./.terraform"
			
		//Attention: These Credentials are different from the ones used to deploy
		// this set is used for the state only!
		sh "terraform init -no-color -backend=true"

                //Select correct environment and corresponding AWS account
                sh "terraform workspace new ${ENVIRONMENT} || terraform workspace select ${ENVIRONMENT}"
	}
	stage("plan") {
		//Run terraform plan to see what will change
		// OPTIONAL set vars using --var-file=[JOB_NAME].tfvars
		// e.g have the vars in the tenant project and apply them to the code to run the setup for this tenant
		sh "terraform plan -var-file=${ENVIRONMENT}.tfvars -no-color -out=plan.out"
	}
	stage("apply") {
		input 'Plese review terraform plan and then decide if you want to apply it?'
		//Run terraform plan to see what will change
		sh "terraform apply -var-file=${ENVIRONMENT}.tfvars -no-color plan.out"
		
		//Write result somewhere
	}
}
