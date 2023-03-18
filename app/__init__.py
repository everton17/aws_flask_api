from flask import Flask
from flask_restful import Api
from resources.healthcheck_resource import HealthcheckResource
from resources.ec2_list_resource import Ec2ListResource

app = Flask(__name__)
api = Api(app)

app.config['ENV'] = 'development'
app.config['DEBUG'] = True
    
api.add_resource(HealthcheckResource, '/healthcheck')
api.add_resource(Ec2ListResource, '/ec2_list')

app.run(port=5000)