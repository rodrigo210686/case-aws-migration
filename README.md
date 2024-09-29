# case-aws-migration

To migrate this application, wewill use the Lift and Shift approach modernizing some application components anduse the AWS cloud service provider. To reach it we will use the following AWSServices.

·       ECSFargate

·       AmazonAurora

·       Route53

·       ECR

·       WAF

·       ApplicationLoad Balancer

·       AWSBackup

·       VPC

·       AmazonCloudWatch

The core foundation infrastructure willbe create using IaaC (Infrastructure as Code) Terraform. Terraform will provideVPC, ECS Fargate, ECR, Aurora Database, IAM, Ec2, WAF, Route 53.

![image](https://github.com/user-attachments/assets/8da42379-82e0-4231-a981-7e186af9ed2d)



**Networking**:

*   **Amazon VPC (Virtual Private Cloud)**:
    

**DNS Management**:

*   **Amazon Route 53**:
    

**Application Layer**:

*   **Amazon Elastic Container Service (ECS) Fargate**
    

*   **Amazon Elastic Container Registry (ECR)**
    

**Security**:

*   **IAM (Identity and Access Management)**:
    

*   **AWS WAF (Web Application Firewall)**:
    

*   **SSL/TLS**:


Migration Steps
===============

**Step 1: Containerization of the Application**

·       Packge the application runningin docker using docker build.

·       Push the container image to **Amazon Elastic Container Registry (ECR)**.

**Step 2: Database Migration**

*   Use **AWS Database Migration Service (DMS)** to move the existing on-premises database to Amazon RDS or Aurora.
    

*   Ensure minimal downtime by performing data replication during migration.
    

*   Test the database migration in a staging environment before cutover.
    

**Step 3: Application Deployment**

*   Deploy the application to **Amazon ECS Fargate** in a VPC with public and private subnets.
    

*   Set up an **Application Load Balancer (ALB)** to route incoming traffic to ECS.
 

**Step 4: DNS Cutover**

*   Point the domain topsurvey.contoso.com to Route 53.

Terraform Code
==============
