from flask_restful import Resource
from flask_restful import reqparse
from models.ec2_instance_type_modify_models import ec2_instance_type_modify

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

        call_aws_api = ec2_instance_type_modify(region=data_region,instance_id=data_instance_id,instance_type=data_instance_type)
        return call_aws_api