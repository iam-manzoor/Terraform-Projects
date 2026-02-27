# AWS Session Manager

- Session Manager gives you the access to the Ec2 instances running in the private subnet without using SSH over the internet.
- Create an IAM role for EC2 instance and attach the `AmazonSSMManagedInstanceCore` policy to the role
- This policy allows user to login to the ec2 instance from the browser without SSH Keys.
- No ports are needed to be allowed in SG
- You can run EC2 instance in the private subnets
- There is no need of SSH keys.
- Manage the EC2 instances using IAM role.
- AMI comes with SSM agent installed. without SSM agent it wont work.

### AMIs with SSM Agnet pre-installed
- Follow official AWS documents

# VPC EndPoints

- Private and Secure connections between a VPC and Supported AWS services without requiring  an `IGW`, `NAT device` or `VPN`
- Traffic doesnt leave AWS network.
### Two types of VPC Endpoints
- **Interface Endpoints:**
    - An Elastic Network Interface (ENI) with a private IP address placed within your subnet that acts as a secure, direct entry point to supported AWS services and PrivateLink-powered services
- **Gateway Endpoints:**
    - Supports only S3/DynamoDB. Free of cost.
    - Update the route table info with gateway endpoint details.
