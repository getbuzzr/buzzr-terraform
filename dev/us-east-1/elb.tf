data "aws_ssm_parameter" "forest_env_secret" {
  name = aws_ssm_parameter.forest_env_secret.name
}
data "aws_ssm_parameter" "forest_auth_secret" {
  name = aws_ssm_parameter.forest_auth_secret.name
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "webserver-eb-ec2-instance-profile-dev"
  role = module.elb_webserver_role.name
}

resource "aws_elastic_beanstalk_application" "buzzr_dev" {
  name        = "buzzr-dev-app"
  description = "The elb environment hosting buzzr api"

  appversion_lifecycle {
    service_role          = module.elb_webserver_role.role_arn
    max_count             = 128
    delete_source_from_s3 = true
  }
}
resource "aws_elastic_beanstalk_application_version" "buzzr_dev_application" {
  name        = "application_verion"
  application = aws_elastic_beanstalk_application.buzzr_dev.name
  description = "application version created by terraform"
  bucket      = module.elb_deploy_bucket.id
  key         = "docker_deploy.zip"
}
resource "aws_elastic_beanstalk_environment" "buzzr_dev_env" {
  name                = "buzzr-dev-env"
  application         = aws_elastic_beanstalk_application.buzzr_dev.name
  solution_stack_name = "64bit Amazon Linux 2 v3.2.5 running Docker"

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 1
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_default_vpc.default.id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = true
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${aws_subnet.public1.id},${aws_subnet.public2.id}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${aws_subnet.public1.id},${aws_subnet.public2.id}"
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = aws_security_group.load_balancer.id
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "ManagedSecurityGroup"
    value     = aws_security_group.load_balancer.id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.ec2_instance_profile.name
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.web_server.id
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  # remove this for prod
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }
  # This destroys ec2 instances to make room for new docker deployments
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "Immutable"
  }
  # This deploy to max one at a time
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MaxBatchSize"
    value     = 1
  }
  # This deploy to max one at a time
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Immutable"
  }
  ###=========================== Logging ========================== ###

  setting {
    namespace = "aws:elasticbeanstalk:hostmanager"
    name      = "LogPublicationControl"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "DeleteOnTerminate"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "RetentionInDays"
    value     = 30
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "HealthStreamingEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "DeleteOnTerminate"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "RetentionInDays"
    value     = 30
  }
  # =========== SSL
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "ListenerEnabled"
    value     = true
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "Protocol"
    value     = "HTTPS"
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "SSLCertificateArns"
    value     = aws_acm_certificate.dev_api_getbuzzr_co.arn
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "SSLPolicy"
    value     = "ELBSecurityPolicy-2016-08"
  }
}





# resource "aws_elastic_beanstalk_application" "buzzr_admin_dev" {
#   name        = "buzzr-dev-admin"
#   description = "The elb environment hosting buzzr admin"

#   appversion_lifecycle {
#     service_role          = module.elb_webserver_role.role_arn
#     max_count             = 128
#     delete_source_from_s3 = true
#   }
# }
# resource "aws_elastic_beanstalk_application_version" "buzzr_dev_admin" {
#   name        = "application_verion"
#   application = aws_elastic_beanstalk_application.buzzr_admin_dev.name
#   description = "application version created by terraform"
#   bucket      = module.admin_deploy_bucket.id
#   key         = "docker_deploy.zip"
# }
# resource "aws_elastic_beanstalk_environment" "buzzr_dev_admin_env" {
#   name                = "buzzr-dev-admin-env"
#   application         = aws_elastic_beanstalk_application.buzzr_admin_dev.name
#   solution_stack_name = "64bit Amazon Linux 2 v3.2.5 running Docker"

#   setting {
#     namespace = "aws:autoscaling:asg"
#     name      = "MinSize"
#     value     = 1
#   }

#   setting {
#     namespace = "aws:autoscaling:asg"
#     name      = "MaxSize"
#     value     = 1
#   }

#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "VPCId"
#     value     = aws_default_vpc.default.id
#   }

#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "AssociatePublicIpAddress"
#     value     = true
#   }

#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "ELBSubnets"
#     value     = "${aws_subnet.public1.id},${aws_subnet.public2.id}"
#   }
#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "Subnets"
#     value     = "${aws_subnet.public1.id},${aws_subnet.public2.id}"
#   }

#   setting {
#     namespace = "aws:elbv2:loadbalancer"
#     name      = "SecurityGroups"
#     value     = aws_security_group.load_balancer.id
#   }
#   setting {
#     namespace = "aws:elbv2:loadbalancer"
#     name      = "ManagedSecurityGroup"
#     value     = aws_security_group.load_balancer.id
#   }
#   setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "IamInstanceProfile"
#     value     = aws_iam_instance_profile.ec2_instance_profile.name
#   }
#   setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "SecurityGroups"
#     value     = aws_security_group.web_server.id
#   }
#   setting {
#     namespace = "aws:elasticbeanstalk:environment"
#     name      = "LoadBalancerType"
#     value     = "application"
#   }
#   # remove this for prod
#   setting {
#     namespace = "aws:elasticbeanstalk:environment"
#     name      = "EnvironmentType"
#     value     = "SingleInstance"
#   }
#   # This destroys ec2 instances to make room for new docker deployments
#   setting {
#     namespace = "aws:elasticbeanstalk:command"
#     name      = "DeploymentPolicy"
#     value     = "Immutable"
#   }
#   # This deploy to max one at a time
#   setting {
#     namespace = "aws:autoscaling:updatepolicy:rollingupdate"
#     name      = "MaxBatchSize"
#     value     = 1
#   }
#   # This deploy to max one at a time
#   setting {
#     namespace = "aws:autoscaling:updatepolicy:rollingupdate"
#     name      = "RollingUpdateType"
#     value     = "Immutable"
#   }
#   ###=========================== Logging ========================== ###

#   setting {
#     namespace = "aws:elasticbeanstalk:hostmanager"
#     name      = "LogPublicationControl"
#     value     = "true"
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:cloudwatch:logs"
#     name      = "StreamLogs"
#     value     = "true"
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:cloudwatch:logs"
#     name      = "DeleteOnTerminate"
#     value     = "true"
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:cloudwatch:logs"
#     name      = "RetentionInDays"
#     value     = 30
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
#     name      = "HealthStreamingEnabled"
#     value     = "true"
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
#     name      = "DeleteOnTerminate"
#     value     = "true"
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
#     name      = "RetentionInDays"
#     value     = 30
#   }
#   # =========== SSL
#   setting {
#     namespace = "aws:elbv2:listener:443"
#     name      = "ListenerEnabled"
#     value     = true
#   }
#   setting {
#     namespace = "aws:elbv2:listener:443"
#     name      = "Protocol"
#     value     = "HTTPS"
#   }
#   setting {
#     namespace = "aws:elbv2:listener:443"
#     name      = "SSLCertificateArns"
#     value     = aws_acm_certificate.dev_admin_getbuzzr_co.arn
#   }
#   setting {
#     namespace = "aws:elbv2:listener:443"
#     name      = "SSLPolicy"
#     value     = "ELBSecurityPolicy-2016-08"
#   }
#   # ==== ENV vars

#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "FOREST_ENV_SECRET"
#     value     = data.aws_ssm_parameter.forest_env_secret.value
#   }
#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "FOREST_AUTH_SECRET"
#     value     = data.aws_ssm_parameter.forest_auth_secret.value
#   }
#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "DATABASE_URL"
#     value     = data.aws_ssm_parameter.api_db_server_uri.value
#   }
#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "NODE_ENV"
#     value     = "production"
#   }
#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "APPLICATION_URL"
#     value     = "https://dev.admin.getbuzzr.co"
#   }
# }
