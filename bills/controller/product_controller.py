from flask import Blueprint, request, jsonify
from utils.database import db
from models import Product, Category

product_blueprint = Blueprint('product_controller', __name__)

@product_blueprint.route('/products', methods=['POST'])
def create_product():
    data = request.json
    name = data.get('name')
    description = data.get('description')
    price = data.get('price')
    category_id = data.get('category_id')

    if not name or not price or not category_id:
        return jsonify({'error': 'Name, price, and category_id are required fields'}), 400

    product = Product(name=name, description=description, price=price, category_id=category_id)
    db.session.add(product)
    db.session.commit()

    return jsonify({'message': 'Product created successfully', 'product': {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'category_id': product.category_id
    }}), 201

@product_blueprint.route('/products', methods=['GET'])
def get_products():
    products = Product.query.all()
    products_list = [{
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'category_id': product.category_id
    } for product in products]
    return jsonify(products_list)

@product_blueprint.route('/products/<int:product_id>', methods=['GET'])
def get_product(product_id):
    product = Product.query.get(product_id)

    if not product:
        return jsonify({'error': 'Product not found'}), 404

    return jsonify({
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'category_id': product.category_id
    })

@product_blueprint.route('/products/<int:product_id>', methods=['PUT'])
def update_product(product_id):
    product = Product.query.get(product_id)

    if not product:
        return jsonify({'error': 'Product not found'}), 404

    data = request.json
    product.name = data.get('name', product.name)
    product.description = data.get('description', product.description)
    product.price = data.get('price', product.price)
    product.category_id = data.get('category_id', product.category_id)

    db.session.commit()

    return jsonify({'message': 'Product updated successfully', 'product': {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'category_id': product.category_id
    }})

@product_blueprint.route('/products/<int:product_id>', methods=['DELETE'])
def delete_product(product_id):
    product = Product.query.get(product_id)

    if not product:
        return jsonify({'error': 'Product not found'}), 404

    db.session.delete(product)
    db.session.commit()

    return jsonify({'message': 'Product deleted successfully'})
