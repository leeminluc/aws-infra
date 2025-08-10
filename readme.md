1. Disable backend configuration temporarily by commenting it from backend.tf

2. Setup S3 and DynamoDB for Terraform remote state
```
init
terraform apply -target=aws_s3_bucket.terraform_state \
-target=aws_dynamodb_table.terraform_locks
```

3. Uncomment the backend configuration then migrate the state
```
terraform init -migrate-state
```

4. Deploy the rest of the Terraform resources
```
terraform apply
```
