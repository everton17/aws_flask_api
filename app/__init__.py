from flask import Flask
from flask_restful import Api
from resources.wellcome_api_resource import WellcomeApiResource
from resources.healthcheck_resource import HealthcheckResource
from resources.ec2_list_resource import Ec2ListResource
from resources.ec2_start_resource import Ec2StartResource
from resources.ec2_stop_resource import Ec2StopResource
from resources.ec2_reboot_resource import Ec2RebootResource
from resources.ec2_instance_type_modify_resource import Ec2InstanceTypeResource

app = Flask(__name__)
api = Api(app)

app.config['ENV'] = 'development'
app.config['DEBUG'] = True
    
api.add_resource(WellcomeApiResource, '/')
api.add_resource(HealthcheckResource, '/healthcheck')
api.add_resource(Ec2ListResource, '/ec2_list')
api.add_resource(Ec2StartResource, '/ec2_start')
api.add_resource(Ec2StopResource, '/ec2_stop')
api.add_resource(Ec2RebootResource, '/ec2_reboot')
api.add_resource(Ec2InstanceTypeResource, '/ec2_instance_type_modify')

app.run(port=5000)