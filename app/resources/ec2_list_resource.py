from flask_restful import Resource
from flask_restful import reqparse
from app.models.ec2_list_models import ec2_list

class Ec2ListResource(Resource):
    parser = reqparse.RequestParser()
    parser.add_argument('region', type=str, required=True, help='aws region is a required paramether, please send desired region as header')
    
    def get(self):
        data_region = Ec2ListResource.parser.parse_args().get('region')
        call_aws_api = ec2_list(region=data_region)
        return call_aws_api