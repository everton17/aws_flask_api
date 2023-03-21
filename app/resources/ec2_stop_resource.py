from flask_restful import Resource
from flask_restful import reqparse
from models.ec2_stop_model import ec2_stop

profile = "tf"

class Ec2StopResource(Resource):
    parser = reqparse.RequestParser()
    parser.add_argument('region', type=str, required=True, help='aws region is a required paramether, please send desired region as header')
    parser.add_argument('instance_id', type=str, required=True, help='instance_id is a required paramether, please send desired instance_id as header')
    
    def post(self):
        data_region = Ec2StopResource.parser.parse_args().get('region')
        data_instance_id = Ec2StopResource.parser.parse_args().get('instance_id')
        
        call_aws_api = ec2_stop(region=data_region, instance_id = data_instance_id)
        return call_aws_api