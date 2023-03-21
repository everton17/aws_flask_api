from flask_restful import Resource

class WellcomeApiResource(Resource):
    def get(self):
        return {"Wellcome": "This is mini aws-ec2-api"}