# Task 3: Infrastructure as Code (IaC) with Terraform

Provision a local Docker container (nginx) using Terraform and the Docker provider.

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Terraform code: Docker provider, nginx image, nginx container |
| `logs/` | Execution logs of init, plan, apply, state and destroy |
| `screenshots/` | Screenshots of the run |

## Commands used
```
terraform init       # download the Docker provider
terraform validate   # check the code
terraform plan       # preview what will be created
terraform apply      # create the container
terraform state list # list resources tracked in the state
terraform state show docker_container.nginx
terraform destroy    # remove everything
```

After `apply`, nginx is available at http://localhost:8085.

## Interview Q&A

**1. What is IaC?**
Infrastructure as Code means managing and provisioning infrastructure (servers, containers, networks) with code files instead of manual clicks, so it is repeatable, versioned and reviewable.

**2. How does Terraform work?**
You describe the desired state in `.tf` files. `terraform init` downloads providers, `plan` compares your code with the real infrastructure and the state file, and `apply` makes the changes needed to match.

**3. What is the Terraform state file?**
`terraform.tfstate` is a file where Terraform records the resources it created and their current attributes. It maps your code to real resources and lets Terraform know what to add, change or delete.

**4. Difference between apply and plan?**
`plan` only shows what would change and makes no changes. `apply` actually creates, updates or deletes the resources.

**5. What are Terraform providers?**
Plugins that let Terraform talk to a platform's API (Docker, AWS, Azure, GCP, Kubernetes). Here we used the `kreuzwerker/docker` provider.

**6. What is resource dependency?**
When one resource needs another. In this project the container uses `docker_image.nginx.image_id`, so Terraform creates the image first (an implicit dependency). `depends_on` can set it explicitly.

**7. How do you handle secret variables?**
Mark variables as `sensitive = true`, pass them with environment variables (`TF_VAR_name`) or a `.tfvars` file that is in `.gitignore`, or use a secrets manager like Vault. Never commit secrets or the state file to Git.

**8. Explain the benefits of Terraform.**
It is cloud-agnostic, declarative, gives a preview with `plan`, keeps infrastructure in version control, is reusable through modules, and makes environments consistent and easy to rebuild or destroy.
