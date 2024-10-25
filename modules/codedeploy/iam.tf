data "aws_caller_identity" "current" {}

### AWS IAM ROLES ###
resource "aws_iam_role" "this" {
  name = "${var.codedeploy_app_name}-codedeploy-role"
  assume_role_policy = templatefile("${path.module}/policies/codedeploy-policy.json", {
    service_principal = "codedeploy.amazonaws.com"
  })
}

### AWS IAM ROLE POLICIES ###
resource "aws_iam_policy" "codedeploy_ecs_policy" {
  count = var.compute_platform == "ECS" ? 1 : 0

  name = "${var.codedeploy_app_name}-codedeploy-ecs-policy"
  path = "/"

  policy = templatefile("${path.module}/policies/codedeploy-ecs-policy.json", {
    aws_account_id = data.aws_caller_identity.current.account_id
  })
}

### AWS IAM ROLE POLICY ATTACHMENTS ###
resource "aws_iam_role_policy_attachment" "aws_code_deploy_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "codedeploy_ecs_policy" {
  count = var.compute_platform == "ECS" ? 1 : 0

  policy_arn = aws_iam_policy.codedeploy_ecs_policy[0].arn
  role       = aws_iam_role.this.name
}
