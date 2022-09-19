data "aws_iam_policy_document" "dynamodb_parsley_rw" {
  statement {
    sid = "DynamoDBIndexAndStreamAccess"
    actions = [
      "dynamodb:GetShardIterator",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:ListStreams",
    ]
    effect = "Allow"
    resources = [
      aws_dynamodb_table.parsley.arn
    ]
  }
  statement {
    sid    = "DynamoDBTableAccess"
    effect = "Allow"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:ConditionCheckItem",
      "dynamodb:PutItem",
      "dynamodb:DescribeTable",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
    ]
    resources = [
      aws_dynamodb_table.parsley.arn
    ]
  }
  statement {
    sid     = "DynamoDBDescribeLimitsAccess"
    effect  = "Allow"
    actions = ["dynamodb:DescribeLimits"]
    resources = [
      aws_dynamodb_table.parsley.arn
    ]
  }
}

resource "aws_iam_policy" "dynamodb_parsley_rw" {
  name        = "DynamoDB Parsley Table Read-Write"
  description = "Provides read-write access to DynamoDB table"
  policy      = data.aws_iam_policy_document.dynamodb_parsley_rw.json
}

resource "aws_iam_role" "developer" {
  name = "Developer Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "developer_role_dyanmo_rw" {
  role       = aws_iam_role.developer.name
  policy_arn = aws_iam_policy.dynamodb_parsley_rw.arn
}

data "aws_iam_policy_document" "dynamodb_parsley_ro" {
  sid    = "ReadOnlyAPIActionsOnBooks"
  effect = "Allow"
  actions = [
    "dynamodb:GetItem",
    "dynamodb:BatchGetItem",
    "dynamodb:Scan",
    "dynamodb:Query",
    "dynamodb:ConditionCheckItem",
  ]
  resources = [
    aws_dynamodb_table.parsley.arn
  ]
}

resource "aws_iam_policy" "dynamodb_parsley_ro" {
  name        = "DynamoDB Parsley Table Read-Only"
  description = "Provides read-only access to DynamoDB table"
  policy      = data.aws_iam_policy_document.dynamodb_parsley_ro.json
}

resource "aws_iam_role_policy_attachment" "pm_role_dynamo_ro" {
  role   = aws_iam_role.product_manager.name
  policy = aws_iam_policy.dynamodb_parsley_ro.arn
}

resource "aws_iam_role" "product_manager" {
  name = "Product Manager Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
