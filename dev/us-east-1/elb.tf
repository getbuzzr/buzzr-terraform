resource "aws_iam_instance_profile" "ec2" {
  name = "webserver-eb-ec2"
  role = module.elb_webserver_role.name
}

resource "aws_elastic_beanstalk_application" "onguard_dev" {
  name        = "onguard-dev"
  description = "The elb environment hosting onguard api"

  appversion_lifecycle {
    service_role          = module.elb_webserver_role.role_arn
    max_count             = 128
    delete_source_from_s3 = true
  }
}

resource "aws_elastic_beanstalk_environment" "onguard_dev_env" {
  name                = "onguard-dev"
  application         = aws_elastic_beanstalk_application.onguard_dev.name
  solution_stack_name = "64bit Amazon Linux 2 v3.2.2 running Docker"

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
    name      = "ELBSubnets"
    value     = "${aws_subnet.public1.id},${aws_subnet.public2.id}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${aws_subnet.private1.id},${aws_subnet.private2.id}"
  }

  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "SecurityGroups"
    value     = aws_security_group.load_balancer.id
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "ManagedSecurityGroup"
    value     = aws_security_group.web_server.id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.ec2.name
  }
    {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "HealthCheckPath"
      value     = "/ping"
    },
    {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "Port"
      value     = "80"
    {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "Protocol"
      value     = "HTTP"
    }
}