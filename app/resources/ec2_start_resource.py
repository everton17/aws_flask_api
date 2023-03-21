from flask_restful import Resource
from flask_restful import reqparse
from models.ec2_start_model import ec2_start

profile = "tf"

class Ec2StartResource(Resource):
    parser = reqparse.RequestParser()
    parser.add_argument('region', type=str, required=True, help='aws region is a required paramether, please send desired region as header')
    parser.add_argument('instance_id', type=str, required=True, help='instance_id is a required paramether, please send desired instance_id as header')
    
    def post(self):
        data_region = Ec2StartResource.parser.parse_args().get('region')
        data_instance_id = Ec2StartResource.parser.parse_args().get('instance_id')

        call_aws_api = ec2_start(region=data_region, instance_id=data_instance_id)
        return call_aws_api