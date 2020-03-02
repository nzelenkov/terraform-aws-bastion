# Exercise 1 Terraform dependencies and variables
## Exercise 1.1 Resource dependencies
## Exercise 1.2 Provision 
## Exercise 1.3 Input variables
## Exercise 1.4 Output variables

# Exercise 2 Modules

# Exercise 3 Simple Web Server
```
curl -s  http://ec2-34-247-2-101.eu-west-1.compute.amazonaws.com/
Hello from AWS Instance ip-172-31-25-107.eu-west-1.compute.internal
```

# Exercise 4
Use ssh agent to tunnel to instances with only private IPs within the VPC
```
ssh-add aws-key.pem
ssh -A ubuntu@privateIp
```

Hostkey possible problems
```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@       WARNING: POSSIBLE DNS SPOOFING DETECTED!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
The ECDSA host key for ec2-34-254-21-135.eu-west-1.compute.amazonaws.com has changed,
and the key for the corresponding IP address 172.31.20.131
is unknown. This could either mean that
DNS SPOOFING is happening or the IP address for the host
and its host key have changed at the same time.
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:FphrSgJCvz0aTIrCnvDAz4tzPtGqy2arTHCA+I0Q1fU.
Please contact your system administrator.
Add correct host key in /home/ubuntu/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /home/ubuntu/.ssh/known_hosts:1
  remove with:
  ssh-keygen -f "/home/ubuntu/.ssh/known_hosts" -R "ec2-34-254-21-135.eu-west-1.compute.amazonaws.com"
Password authentication is disabled to avoid man-in-the-middle attacks.
Keyboard-interactive authentication is disabled to avoid man-in-the-middle attacks.
```


# Exercise 5
export DO_AUTH_TOKEN=**REPLACE_WITH_YOUR_DO_TOKEN_HERE**
terraform plan -out deploy.tfplan -var "do_token=$DO_AUTH_TOKEN" -var "pvt_key=${HOME}/.ssh/aws-key.pem"
terraform apply "deploy.tfplan"
terraform plan -destroy -out destroy.tfplan -var "do_token=$DO_AUTH_TOKEN" -var "pvt_key=${HOME}/.ssh/aws-key.pem"
terraform apply "destroy.tfplan"

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations! You have successfully enabledA
https://web01.dev.3zinventions.com

You should test your configuration at:
https://www.ssllabs.com/ssltest/analyze.html?d=web.pix4d.dev.3zinventions.com
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/web.pix4d.dev.3zinventions.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/web01.dev.3zinventions.com/privkey.pem
   Your cert will expire on 2019-05-12. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot again
   with the "certonly" option. To non-interactively renew *all* of
   your certificates, run "certbot renew"

# Exercise 6