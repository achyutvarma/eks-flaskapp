# 🚀 Simple Flask App Deployment on Amazon EKS

This guide explains how to deploy a basic Flask web application on Amazon EKS.

---

## 📦 Prerequisites

Ensure the following tools are installed on your **local machine or VM**:

- [`kubectl`](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)
- [`aws-cli`](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [`eksctl`](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)

---

## 🔐 Configure AWS CLI

```bash
aws configure
Provide the following details:

AWS Access Key ID

AWS Secret Access Key

Region (e.g., us-east-1)

Verify configuration:
aws sts get-caller-identity

☸️ Create EKS Cluster

eksctl create cluster \
  --name flaskapp-cluster \
  --region us-east-1 \
  --nodegroup-name linux-nodes \
  --node-type t3.medium \
  --nodes 2 \
  --nodes-min 1 \
  --nodes-max 3 \
  --managed
🐳 Build and Push Docker Image to Amazon ECR

1. Create a repository in Amazon ECR:
aws ecr create-repository --repository-name flask-app

2. Authenticate Docker to your ECR:
aws ecr get-login-password --region us-east-1 | \
docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com

3. Build and tag the Docker image:
docker build -t flask-app .
docker tag flask-app:latest <account-id>.dkr.ecr.us-east-1.amazonaws.com/flask-app:latest

4. Push the image to ECR:

docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/flask-app:latest
🔗 Connect to the EKS Cluster

aws eks --region us-east-1 update-kubeconfig --name flaskapp-cluster

🚀 Deploy the Application to EKS
Apply your Kubernetes manifests:

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

🌐 Access the Web Application
To get the external IP:
kubectl get service

Look for the EXTERNAL-IP under your service (usually of type LoadBalancer), then open:
http://<external-ip>

✅ Done!
Your Flask app should now be accessible via the public IP provided by the LoadBalancer.


