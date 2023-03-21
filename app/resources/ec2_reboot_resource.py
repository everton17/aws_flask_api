from flask_restful import Resource
from flask_restful import reqparse
from models.ec2_reboot_model import ec2_reboot

profile = "tf"

class Ec2RebootResource(Resource):
    parser = reqparse.RequestParser()
    parser.add_argument('region', type=str, required=True, help='aws region is a required paramether, please send desired region as header')
    parser.add_argument('instance_id', type=str, required=True, help='instance_id is a required paramether, please send desired instance_id as header')
    
    def post(self):
        data_instance_id = Ec2RebootResource.parser.parse_args().get('instance_id')
        data_region = Ec2RebootResource.parser.parse_args().get('region')

        call_aws_api = ec2_reboot(region=data_region, instance_id=data_instance_id)
        return call_aws_api