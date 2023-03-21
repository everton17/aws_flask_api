from flask_restful import Resource
from flask_restful import reqparse
import botocore
import boto3

profile = "tf"

class Ec2StopResource(Resource):
    parser = reqparse.RequestParser()
    parser.add_argument('region', type=str, required=True, help='aws region is a required paramether, please send desired region as header')
    parser.add_argument('instance_id', type=str, required=True, help='instance_id is a required paramether, please send desired instance_id as header')
    
    def get(self):
        data_region = Ec2StopResource.parser.parse_args().get('region')
        data_instance_id = Ec2StopResource.parser.parse_args().get('instance_id')
        region = data_region
        instance_id = data_instance_id
        session = boto3.Session(profile_name=profile, region_name=region)
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