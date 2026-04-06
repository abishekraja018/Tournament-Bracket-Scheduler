Tournament Bracket Scheduler is a scheduler for e-sports as well as sports tournaments.

## Jenkins + Azure VM deploy

This project is a static site, so the Jenkins pipeline does not build an application binary. It packages the site files into `dist/` and deploys them to an Azure VM over SSH.

### Files added for deployment

- [Jenkinsfile](Jenkinsfile)
- [scripts/build.sh](scripts/build.sh)
- [scripts/deploy.sh](scripts/deploy.sh)

### Azure VM setup

1. Create an Azure VM with SSH access enabled.
2. Install a web server on the VM, such as `nginx` or `apache2`.
3. Create a deployment directory, for example `/var/www/tournament-scheduler`.
4. Make sure the SSH user used by Jenkins can write to that directory.

### Jenkins setup

1. Install Jenkins on a VM or service that can reach the Azure VM over SSH.
2. Add an SSH credential in Jenkins, for example `azure-vm-ssh-key`.
3. Configure a pipeline job that uses this repository.
4. Set these pipeline parameters when you run the job:
	- `DEPLOY_HOST`: Azure VM public IP or DNS name
	- `DEPLOY_USER`: SSH username on the VM
	- `DEPLOY_PATH`: target directory on the VM
	- `SSH_PORT`: SSH port, usually `22`

### What the pipeline does

1. Checks out the repository.
2. Runs `scripts/build.sh` to create a `dist/` folder.
3. Uses SSH to push the contents of `dist/` to the Azure VM.

### Accessing the site

After deployment, point your browser to the VM's public IP or domain name.
