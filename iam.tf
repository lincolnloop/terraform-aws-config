##########################################
#  IAM Resources                         #
##########################################

resource "aws_iam_role" "config" {
  name               = var.iam_role_name
  path               = var.iam_role_path
  assume_role_policy = data.aws_iam_policy_document.config.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "config" {
  count      = length(var.iam_managed_policy_arns)
  policy_arn = element(var.iam_managed_policy_arns, count.index)
  role       = aws_iam_role.config.name
}