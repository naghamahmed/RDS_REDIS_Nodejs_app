## <font size=”20”> **RDS_REDIS_Nodejs_app** </font>
## <font size=”20”> **Provision AWS Infrastructure using Terraform** </font>

- vpc
- INTERNET-GATEWAY
- 2 public subnet
- 2 private subnet
- NAT-GATEWAY
- Private EC2 (Application)
- Public EC2 (Bastion-host)
- RDS (in the private subnets)
- Elasticache (in the private subnets)
- ALB


## <font size=”20”> **Jenkins Pipeline for Apply Terrraform** </font>

```
$ cd ./Jenkins-TF
```
```
$ docker build -t jenkins:v1
```
```
$ docker run -d -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker
```

## <front size="20"> **Jenkins Master** </front>

BROWSER
```
http://localhost:8080
```
## <front size="20"> **Configuring AWS on Jenkins** </front>
JENKINS

Adding AWS credentials in secret text 

  **Dashboard > Manage Jenkins > Credentials > system > Global credentials (unrestricted) + Add Credentials**
    
![Screenshot from 2023-02-26 09-23-41](https://user-images.githubusercontent.com/110065223/221398350-430af5e2-607b-449f-926b-662d456847c7.png)

## <front size="20"> **Jenkins parameterized pipeline** </front>
```
$ cat Jenkins-TF/Jenkinsfile
```
![Screenshot from 2023-02-26 09-46-19](https://user-images.githubusercontent.com/110065223/221398556-a7ad9b22-48cc-4c66-92b0-fccf0021ab8c.png)
![Screenshot from 2023-02-26 09-48-40](https://user-images.githubusercontent.com/110065223/221399412-0e26d83f-5785-494a-8e52-bc453495d5dd.png)

## <front size="20"> **Configuring Applicating EC2 as Jenkins-Slave** </front>
## configuring ProxyJump
```
$ sudo vim ~/.ssh/config
```
copy the ec2 private-key in ~/.ssh

```
Host bastion-host
HostName <bastion public_ip>
User ubuntu
Port 22
IdentityFile ~/.ssh/key_pair.pem
IdentitiesOnly yes

Host application
HostName <application private_ip>
User ubuntu
Port 22
IdentityFile ~/.ssh/key_pair.pem
IdentitiesOnly yes
ProxyCommand ssh bastion-host -W %h:%p
```
```
$ cd ./Ansible
```
```
$ ansible-playbook -i hosts main.yml
```
## <front size="20"> **Configuring Jenkins-Master** </front>
![Screenshot from 2023-02-26 06-56-50](https://user-images.githubusercontent.com/110065223/221399312-6530aa0f-5099-40ef-b630-89b345148b7c.png)

Exec to the jenkins master image 
```
$ docker exec -it $container_id bash
```
![Screenshot from 2023-02-26 06-58-42](https://user-images.githubusercontent.com/110065223/221399321-4415e390-63e6-4413-a5b4-9a890cf45cc8.png)

In Jenkins-Master image

Copying the RDS_PASSWORD
```
$ export AWS_ACCESS_KEY_ID="aws access key"
```
```
$ export AWS_ACCESS_SECRET_KEY_ID="aws secret key"
```
```
$ cd /var/jenkins_home/workspace/Database/
```
```
$ terraform output RDS_PASSWORD
```

## <front size="20"> **Jenkins Dashboard** </front>
Dashboard > Manage Jenkins > Manage nodes and clouds  + Add Node
![Screenshot from 2023-02-26 07-05-49](https://user-images.githubusercontent.com/110065223/221399208-7336bdda-9953-40e1-a0fc-aa3078ae9a1b.png)
![Screenshot from 2023-02-26 07-07-01](https://user-images.githubusercontent.com/110065223/221399343-639590e2-d9a7-48b3-80aa-3e7b4c9cf21d.png)

## <front size="20"> **RDS-REDIS Pipleline** </front>

Adding RDS Credentials

Adding DockerHub Credentials
![Screenshot from 2023-02-26 10-25-35](https://user-images.githubusercontent.com/110065223/221400447-0fee0ef0-6df0-47b8-82ca-4b1fb9a575a4.png)


```
$ cd ./Jenkins-App/Jenkinsfile
```
![Screenshot from 2023-02-26 09-48-40](https://user-images.githubusercontent.com/110065223/221400160-7ca1edcd-ea3c-45e8-a3df-be1267be7e04.png)

## <front size="20"> **Expose the app using ALB** </front>

![Screenshot from 2023-02-26 07-49-45](https://user-images.githubusercontent.com/110065223/221400209-e51e27f2-56eb-40f6-9b38-35bb5db1967f.png)

![Screenshot from 2023-02-26 07-45-15](https://user-images.githubusercontent.com/110065223/221400210-26d4a21c-7ed2-484c-8334-0cd7b67a8b08.png)



