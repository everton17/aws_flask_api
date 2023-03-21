import botocore
import boto3

profile= "tf"

def ec2_start(region, instance_id):
    session = boto3.Session(profile_name=profile, region_name=region)
    ec2 = session.client('ec2')

    try:
        check_status_instance = ec2.describe_instances(InstanceIds=[instance_id])["Reservations"][0]["Instances"][0]["State"]["Name"]
        if check_status_instance == 'stopped':
            ec2_start = ec2.start_instances(InstanceIds=[instance_id])
            message = {"message": f"The EC2 Instance {instance_id} is starting"}
            return message
        else:
            message = {"message": f"The EC2 Instance {instance_id} does not midified, because it's started or modifying"}
            return message
    except botocore.exceptions.EndpointConnectionError:
        message = {"error": "Endpoint Connection Error, check if you send a valid aws region as json format on your body request"}
        return message
    except botocore.exceptions.ClientError:
        message = {"error": "Invalid Instance_Id"}
        return message