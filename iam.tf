##########################################
#  IAM Resources                         #
##########################################

resource "aws_iam_role" "config" {
  count              = var.service_linked_role ? 0 : 1
  name               = var.iam_role_name
  path               = var.iam_role_path
  assume_role_policy = data.aws_iam_policy_document.config.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "config" {
  count      = var.service_linked_role ? 0 : 1
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
  role       = aws_iam_role.config[0].name
}
