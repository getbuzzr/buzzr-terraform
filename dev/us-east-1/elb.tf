resource "aws_elastic_beanstalk_application" "onguard_dev" {
  name        = "onguard-dev"
  description = "The elb environment hosting onguard api"

  appversion_lifecycle {
    service_role          = module.elb_webserver_role.arn
    max_count             = 128
    delete_source_from_s3 = true
  }
}

resource "aws_elastic_beanstalk_environment" "onguard_dev_env" {
  name                = "onguard-dev"
  application         = aws_elastic_beanstalk_application.onguard_dev.name
  solution_stack_name = "64bit Amazon Linux 2 v3.2.2 running Docker"
}