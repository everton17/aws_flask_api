import botocore
import boto3

def ec2_stop(region, instance_id):
    session = boto3.Session(region_name=region)
    ec2 = session.client('ec2')

    try:
        check_status_instance = ec2.describe_instances(InstanceIds=[instance_id])["Reservations"][0]["Instances"][0]["State"]["Name"]
        if check_status_instance == 'running':
            ec2_start = ec2.stop_instances(InstanceIds=[instance_id])
            message = {"message": f"The EC2 Instance {instance_id} is stoping"}
            return message
        else:
            message = {"message": f"The EC2 Instance {instance_id} does not midified, because it's stoped or modifying"}
            return message
    except botocore.exceptions.EndpointConnectionError:
        message = {"error": "Endpoint Connection Error, check if you send a valid aws region as json format on your body request"}
        return message
    except botocore.exceptions.ClientError:
        message = {"error": "Invalid Instance_Id"}
        return message