@Library('devops-jenkins-shared-library@smri-asn') _

def COLOR_MAP = ['SUCCESS': 'good', 'FAILURE': 'danger', 'UNSTABLE': 'danger', 'ABORTED': 'danger']
def gitbranch = BRANCH_NAME

if ( gitbranch == 'main' ) {
  aws_account = 'smri-asn-nonprod-jenkins-iac'
} else if ( gitbranch == 'uat' ) {
  aws_account = 'smri-asn-nonprod-jenkins-iac'
} else { //devops
  aws_account = 'smri-asn-nonprod-jenkins-iac'
}

BUIACPipeline (aws_account: "${aws_account}",
                gitbranch:   "${gitbranch}")