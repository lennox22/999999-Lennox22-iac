terragrunt_source = "git::https://git.rockfin.com/training-iac/training-ecs-website.git?ref=X.X.X"    # Substitute X with the latest release

#-----------------------------------------------------
#-----------------Infrastructure Tags-----------------
#-------------REQUIRED - MUST BE FILLED OUT-----------

app_tags = {
development-team-email          = "devteamowner@quickenloans.com"
infrastructure-team-email       = "infrastructureteamowner@quickenloans.com"
infrastructure-engineer-email   = "engineer@quickenloans.com"
hal-app-id                      = "999"
}

#-----------------------------------------------------
#--------------Infrastructure Variables---------------
#-----------------------------------------------------

aws_region              = "us-east-2"
vpc_id                  = "vpc-08850982ee9a0f0a1"
subnet_ids              = [ "subnet-046134d61fe120cbc", "subnet-0f876b2913eb84f4b", "subnet-09fa2d9414fe47482" ]
alb_public_subnet_ids   = [ "subnet-013c830b5b448157e", "subnet-086df96fe15ae9076", "subnet-06f1a762865b7ad3c" ]
route_53_zone_id        = "Z31JSDTYMSU0JR"                      # get from Route 53
website_dns_name        = "YOURNAME.test.training.foc.zone"          # zone must already exist in Route 53
app_id                  = "999999"
application_name        = "YOURNAME"                           # Alphanumeric LOWERCASE characters ONLY, 16 characters MAX. DO NOT EXCEED
environment             = "test"                               # Must match the environment of the cluster, this is how it determines cluster placement
health_check_path       = "/"                   # Health check path for your application
desired_number_of_tasks = 1	                    # Recommended values: 1 for dev/test, 3(or however many subnets you have) for beta/prod
min_number_of_tasks	= 1	                    # Recommended values: 1 for dev/test, 3(or however many subnets you have) for beta/prod
max_number_of_tasks	= 1	                    # Recommended values: 1 for dev/test, 9(or however many subnets you have) for beta/prod
use_blue_green	        = false	                # Recommended values: false for dev/test/beta, true for prod
use_auto_scaling	= false	                # Recommended values: false for dev/test, true for beta/prod
