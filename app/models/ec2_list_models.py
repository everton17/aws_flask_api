import botocore
import boto3

profile= "tf"

def ec2_list(region):
    session = boto3.Session(profile_name=profile, region_name=region)
    ec2 = session.client('ec2')
    ec2_list = []
    try:
        check_ec2 = ec2.describe_instances()['Reservations']
    except botocore.exceptions.EndpointConnectionError:
        message = {"error": "Endpoint Connection Error, check if you send a valid aws region as json format on your body request"}
        return message
    if not len(check_ec2) > 0:
        message = {"message": f"Dont exists EC2 Intances on {region} region"}
        return message
    for result in check_ec2:
        for data in result["Instances"]:
            instance_id = data["InstanceId"]
            instance_type = data["InstanceType"]
            instance_status = data["State"]["Name"]
            if "Tags" in data:
                tag_extract = data["Tags"]
                tag_name = tag_extract[0]
                tag_name_extract = tag_name.get("Value")
            else:
                tag_name_extract = "Instance not Named"               
            info_instances = {"Instance_name": tag_name_extract, "instance_id": instance_id, "instance_type": instance_type, "instance_state": instance_status}
            ec2_list.append(info_instances)
            message = {"ec2_instances": ec2_list}

    return message