from flask_restful import Resource
import boto3



class Ec2ListResource(Resource):
    def get(self):
        region = 'us-east-1'
        session = boto3.Session(profile_name='hashicorp', region_name=region)
        ec2 = session.client('ec2')
        check_ec2 = ec2.describe_instances()['Reservations']
        ec2_list = []
        if not len(check_ec2) > 0:
            message = {"message": f"Dont exists EC2 Intances on {region} region"}
            return message
        for result in check_ec2:
            for data in result["Instances"]:
                instance_id = data["InstanceId"]
                instance_type = data["InstanceType"]
                instance_status = data["State"]["Name"]
                message = {"instance_id": instance_id, "instance_type": instance_type, "instance_state": instance_status}
                ec2_list.append(message)

        return ec2_list
