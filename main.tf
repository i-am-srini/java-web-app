locals {
  assessment_ruleset = compact([
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-rD1z6dpl",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-JJOtZiqQ",
    ]
  )
}

data "aws_iam_policy_document" "inspector_event_role_policy" {
  statement {
    sid = "StartAssessment"
    actions = [
      "inspector:StartAssessmentRun",
    ]
    resources = [
      "*"
    ]
  }
}
resource "aws_inspector_resource_group" "res" {
  tags = {
      instance_id ="i-0c0423a53ab3bd4da"
  }
}

resource "aws_inspector_assessment_target" "assessment" {
  name = "${var.name_prefix}-assessment-target"
  resource_group_arn = aws_inspector_resource_group.res.arn
}

resource "aws_inspector_assessment_template" "assessment" {
  name               = "${var.name_prefix}-assessment-template"
  target_arn         = aws_inspector_assessment_target.assessment.arn
  duration           = var.assessment_duration
  rules_package_arns = local.assessment_ruleset
}

resource "aws_iam_role" "inspector_event_role" {
  name  = "${var.name_prefix}-inspector-event-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "inspector_event" {
  name   = "${var.name_prefix}-inspector-event-policy"
  role   = aws_iam_role.inspector_event_role.id
  policy = data.aws_iam_policy_document.inspector_event_role_policy.json
}

output "arn_awscli" {
  value = aws_inspector_assessment_template.assessment.id
}

variable "access-key"{
  type = string
}

variable "secret-key"{   
  type = string
}
