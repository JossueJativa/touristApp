from flask import Flask 
from utils.database import db
import os

from controller import category_blueprint, product_blueprint, bill_header_blueprint, bill_details_blueprint

app = Flask(__name__)

# Configuración de la base de datos
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite3'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = os.environ.get('FLASK_SECRET_KEY', 'a_default_secret_key_for_development')

# Inicialización de la base de datos
db.init_app(app)

# Registrar blueprints
app.register_blueprint(category_blueprint)
app.register_blueprint(product_blueprint)
app.register_blueprint(bill_header_blueprint)
app.register_blueprint(bill_details_blueprint)

# Crear las tablas si no existen
with app.app_context():
    db.create_all()

if __name__ == "__main__":
    app.run(debug=True, port=8002)