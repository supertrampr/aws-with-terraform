locals {
  ssh_connection = <<EOT
The instance has been deployed, you can connect to it by running command:

    ssh -i ${path.module}/${local_file.ssh.filename} ubuntu@${try(module.ec2_instance.instance_public_ip, "")}

EOT
}