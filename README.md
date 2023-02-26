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
$ cd Jenkins-TF
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

![Screenshot from 2023-02-26 09-46-19](https://user-images.githubusercontent.com/110065223/221398655-16204168-e230-4231-9457-f98e8096c762.png)

## <front size="20"> **Configuring Applicating EC2 as Jenkins-Slave** </front>
## configuring ProxyJump
```
$ sudo vim ~/.ssh/config
```
copy the ec2 private-key in ~/.ssh

```Host bastion-host
HostName 3.76.102.157
User ubuntu
Port 22
IdentityFile ~/.ssh/key_pair.pem
IdentitiesOnly yes

Host application
HostName 10.0.3.99
User ubuntu
Port 22
IdentityFile ~/.ssh/key_pair.pem
IdentitiesOnly yes
ProxyCommand ssh bastion-host -W %h:%p
```
```
$ cd /Ansible
```
```
$ ansible-playbook -i hosts main.yml
```
## <front size="20"> **Configuring Jenkins-Master** </front>
![Screenshot from 2023-02-26 06-56-50](https://user-images.githubusercontent.com/110065223/221399312-6530aa0f-5099-40ef-b630-89b345148b7c.png)
![Screenshot from 2023-02-26 06-58-42](https://user-images.githubusercontent.com/110065223/221399321-4415e390-63e6-4413-a5b4-9a890cf45cc8.png)

## <front size="20"> **Jenkins Dashboard** </front>
Dashboard > Manage Jenkins > Manage nodes and clouds  + Add Node
![Screenshot from 2023-02-26 07-05-49](https://user-images.githubusercontent.com/110065223/221399208-7336bdda-9953-40e1-a0fc-aa3078ae9a1b.png)
![Screenshot from 2023-02-26 07-07-01](https://user-images.githubusercontent.com/110065223/221399343-639590e2-d9a7-48b3-80aa-3e7b4c9cf21d.png)


