{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::${bucket}"
      ],
      "Condition": {
        "StringNotLike": {
          "aws:userId": ${all_userids}
        }
      }
    }
  ]
}