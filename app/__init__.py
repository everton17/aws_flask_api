import os
from flask import Flask
from flask_restful import Api
from app.resources.wellcome_api_resource import WellcomeApiResource
from app.resources.healthcheck_resource import HealthcheckResource
from app.resources.ec2_list_resource import Ec2ListResource
from app.resources.ec2_start_resource import Ec2StartResource
from app.resources.ec2_stop_resource import Ec2StopResource
from app.resources.ec2_reboot_resource import Ec2RebootResource
from app.resources.ec2_instance_type_modify_resource import Ec2InstanceTypeResource

def create_app():

    app = Flask(__name__)
    api = Api(app)

    #app.config['ENV'] = 'development'
    #app.config['DEBUG'] = True

    if 'FLASK_CONFIG' in os.environ.keys():
        app.config.from_object('app.settings.' + os.environ['FLASK_CONFIG'])
    else:
        app.config.from_object('app.settings.Development')

    api.add_resource(WellcomeApiResource, '/')
    api.add_resource(HealthcheckResource, '/healthcheck')
    api.add_resource(Ec2ListResource, '/ec2_list')
    api.add_resource(Ec2StartResource, '/ec2_start')
    api.add_resource(Ec2StopResource, '/ec2_stop')
    api.add_resource(Ec2RebootResource, '/ec2_reboot')
    api.add_resource(Ec2InstanceTypeResource, '/ec2_instance_type_modify')

    return app