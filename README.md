# Swimlane DevOps Practical

This is a demo application to use for working on the Swimlane DevOps hiring practical project.

### Install

Required environment variables:
- `MONGODB_URL` - Full MongoDB connection URI to connect to

### Testing Locally
```sh
git clone git://github.com/swimlane/devops-practical.git
npm install
cp .env.example .env
npm start
```



Steps to Deploy
Build Docker images:

bash
cd docker/app
docker build -t devops-app:latest .
cd ../mongodb
docker build -t devops-mongo:5.0 .
Push images to registry:

bash
docker tag devops-app:latest my-registry/devops-app:v1.0.0
docker push my-registry/devops-app:v1.0.0



Create EKS cluster with Terraform:

# While creating the eks cluster with terraform, encountered an issue stating that You've reached your quota for maximum Fleet Requests for this account. Launching EC2 instance failed.

# Tried by creating manual eks cluster with ec2 and still the issue persists.
![alt text](<Screenshot 2025-09-17 at 10.04.08 AM.png>)

# But the mongo db image is running on local docker and added an entry from the local host
[http://localhost:3000/]

![alt text](<Screenshot 2025-09-16 at 5.22.07 PM.png>)