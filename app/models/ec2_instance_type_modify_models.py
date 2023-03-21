import botocore
import boto3

def ec2_instance_type_modify(region, instance_id, instance_type):
    session = boto3.Session(region_name=region)
    ec2 = session.client('ec2')

    try:
        check_instance = ec2.describe_instances(InstanceIds=[instance_id])["Reservations"][0]["Instances"][0]
        if check_instance["State"]["Name"] == 'stopped' and instance_type != check_instance["InstanceType"]:
            ec2_start = ec2.modify_instance_attribute(InstanceId=instance_id, Attribute='instanceType', Value=instance_type)
            message = {"message": f"The EC2 {instance_id} Instance Type is modifying to {instance_type}, wait a moment and start instance"}
            return message
        else:
            message = {"message": f"The EC2 {instance_id} Instance Type does not midified, because it's running or desired Instance Type is applied"}
            return message
    except botocore.exceptions.EndpointConnectionError:
        message = {"error": "Endpoint Connection Error, check if you send a valid aws region as json format on your body request"}
        return message
    except botocore.exceptions.ClientError:
        message = {"error": "Invalid Instance_Id or Invalida Instance Type"}
        return message