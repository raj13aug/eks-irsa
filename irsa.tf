provider "kubernetes" {
  config_path = "~/.kube/config"
}


resource "aws_s3_bucket" "bucket" {
  bucket = "my-irsa-eks-test-bucket"

  tags = {
    Name        = "My bucket test"
    Environment = "Demo"
  }
}

data "aws_iam_policy_document" "document" {
  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:us-east-1:932999788441:my-irsa-eks-test-bucket:*",
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "simple-policy-for-testing-irsa"
  policy      = data.aws_iam_policy_document.document.json
  description = "Policy for testing irsa"
}

module "irsa" {
  source           = "github.com/ministryofjustice/cloud-platform-terraform-irsa?ref=1.0.5"
  eks_cluster_name = var.eks_cluster_name
  namespace        = "default"
  service_account  = "iam-test"
  role_policy_arns = [aws_iam_policy.policy.arn]
}