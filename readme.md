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

5. Install and Bootstrap Flux
```
curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.6.0 bash
GITHUB_TOKEN=ghp_xxxxxx

flux bootstrap github \
    --owner=leeminluc \
    --repository=gitops \
    --path=clusters/aws_k3s \
    --private=true --personal=true \
    --components-extra=image-reflector-controller,image-automation-controller \
    --read-write-key
```

