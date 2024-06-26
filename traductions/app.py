from flask import Flask 
from controller.traduction_controller import traduction_blueprint

app = Flask(__name__)

app.register_blueprint(traduction_blueprint)

if __name__ == '__main__':
    app.run(debug=True, port=8004)