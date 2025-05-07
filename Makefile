ifeq ($(environment),)
$(error environment is not set)
endif

project := "asn-v2"
terraform_bucket := ""
ifeq ($(environment), production)
	profile := production
	region :=  ap-southeast-1
	account_id := ""
	terraform_bucket := "smri-asn-tfstate"
	environment_tag := "Production"
else ifeq ($(environment), staging)
	profile := staging
	region :=  ap-southeast-1
	account_id := ""
	terraform_bucket := "smri-asn-tfstate"
	environment_tag := "Staging"
else ifeq ($(environment), develop)
	profile := develop
	region :=  ap-southeast-1
	account_id := ""
	terraform_bucket := "smri-asn-tfstate"
	environment_tag := "Development"
else ifeq ($(environment), uat)
	profile := uat
	region :=  ap-southeast-1
	account_id := ""
	terraform_bucket := "smri-asn-tfstate"
	environment_tag := "uat"
else
$(error environment is not valid)
endif

workspace := $(project)-$(environment)

main_bu := "RETAIL"
sub_bu := "SMRI"
company := "smri"
company_short_name := "SMRI"
project_name := "ASN Tech Refresh"
application_name := "ASN Tech Refresh"
department_name := "Information Technology"
company_to_charge := "SM RETAIL Inc."
owner := DevOps
map_migrated := mig34294

terraform-init:
	ls -lars 
	aws configure list-profiles
	terraform init \
	-backend-config="profile=${profile}" \
        -backend-config="region=${region}" \
        -backend-config="bucket=$(terraform_bucket)";

terraform-validate:
	terraform validate

terraform-plan:
	 
	ls -lars 
	aws configure list-profiles
	terraform init \
    	-backend-config="profile=${profile}" \
        -backend-config="region=${region}" \
        -backend-config="bucket=$(terraform_bucket)"; 
	terraform workspace select $(workspace) || terraform workspace new $(workspace); 
	terraform plan -out $(environment).tfout \
		-var=aws_profile=$(profile) \
		-var=project=$(project) \
		-var=environment=$(environment) \
		-var=environment_tag=$(environment_tag) \
		-var=main_bu=$(main_bu) \
		-var=sub_bu=$(sub_bu) \
		-var=company=$(company) \
		-var=company_short_name=$(company_short_name) \
		-var=project_name=$(project_name) \
		-var=application_name=$(application_name) \
		-var=department_name=$(department_name) \
		-var=aws_region=${region} \
		-var=company_to_charge=${company_to_charge} \
		-var=owner=${owner} \
		-var=map_migrated=${map_migrated} \
		-input=false;

terraform-apply:
	terraform init \
        	-backend-config="profile=${profile}" \
        	-backend-config="region=${region}" \
        	-backend-config="bucket=$(terraform_bucket)"; 
	terraform workspace select $(workspace) || terraform workspace new $(workspace); 
	terraform plan -out $(environment).tfout \
		-var=aws_profile=$(profile) \
		-var=project=$(project) \
		-var=environment=$(environment) \
		-var=environment_tag=$(environment_tag) \
		-var=main_bu=$(main_bu) \
		-var=sub_bu=$(sub_bu) \
		-var=company=$(company) \
		-var=company_short_name=$(company_short_name) \
		-var=project_name=$(project_name) \
		-var=application_name=$(application_name) \
		-var=department_name=$(department_name) \
        -var=aws_region=${region} \
		-var=company_to_charge=$(company_to_charge) \
		-var=owner=${owner} \
		-var=map_migrated=${map_migrated} \
		-input=false; \
	terraform apply $(environment).tfout;
 