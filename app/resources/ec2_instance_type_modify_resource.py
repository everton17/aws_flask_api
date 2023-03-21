from flask_restful import Resource
from flask_restful import reqparse
import botocore
import boto3

profile = "tf"

class Ec2InstanceTypeResource(Resource):
    parser = reqparse.RequestParser()
    parser.add_argument('region', type=str, required=True, help='aws region is a required paramether, please send desired region as header')
    parser.add_argument('instance_id', type=str, required=True, help='instance_id is a required paramether, please send desired instance_id as header')
    parser.add_argument('instance_type', type=str, required=True, help='instance_type is a required paramether, please send desired instance_type as header')
    
    def post(self):
        data_region = Ec2InstanceTypeResource.parser.parse_args().get('region')
        data_instance_id = Ec2InstanceTypeResource.parser.parse_args().get('instance_id')
        data_instance_type = Ec2InstanceTypeResource.parser.parse_args().get('instance_type')
        region = data_region
        instance_id = data_instance_id
        instance_type = data_instance_type
        session = boto3.Session(profile_name=profile, region_name=region)
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