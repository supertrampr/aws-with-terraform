
# [tfsec] Results
## Failed: 5 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-ec2-add-description-to-security-group` | *LOW* | _Missing description for security group._ | `ec2.tf:17-43` | Security group explicitly uses the default description. |
| 2 | `aws-ec2-enable-at-rest-encryption` | *HIGH* | _Instance with unencrypted block device._ | `ec2.tf:45-63` | Root block device is not encrypted. |
| 3 | `aws-ec2-enforce-http-token-imds` | *HIGH* | _aws_instance should activate session tokens for Instance Metadata Service._ | `ec2.tf:45-63` | Instance does not require IMDS access to require a token |
| 4 | `aws-ec2-no-public-ip-subnet` | *HIGH* | _Instances in a subnet should not receive a public IP address by default._ | `network.tf:22` | Subnet associates public IP address. |
| 5 | `aws-ec2-require-vpc-flow-logs-for-all-vpcs` | *MEDIUM* | _VPC Flow Logs is a feature that enables you to capture information about the IP traffic going to and from network interfaces in your VPC. After you've created a flow log, you can view and retrieve its data in Amazon CloudWatch Logs. It is recommended that VPC Flow Logs be enabled for packet "Rejects" for VPCs._ | `network.tf:1-7` | VPC Flow Logs is not enabled for VPC  |

