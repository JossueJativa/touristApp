from flask import request, jsonify, Blueprint
from utils.database import db
from models import Category

category_blueprint = Blueprint('category_controller', __name__)

@category_blueprint.route('/categories', methods=['POST'])
def create_category():
    name = request.json.get('name')

    if not name:
        return jsonify({'error': 'Name is required'}), 400

    category = Category(name=name)
    db.session.add(category)
    db.session.commit()

    return jsonify({'message': 'Category created successfully', 'category': category.name}), 201

@category_blueprint.route('/categories', methods=['GET'])
def get_categories():
    categories = Category.query.all()
    categories_list = [{'id': category.id, 'name': category.name} for category in categories]
    return jsonify(categories_list)

@category_blueprint.route('/categories/<int:category_id>', methods=['GET'])
def get_category(category_id):
    category = Category.query.get(category_id)

    if not category:
        return jsonify({'error': 'Category not found'}), 404

    return jsonify({'id': category.id, 'name': category.name})

@category_blueprint.route('/categories/<int:category_id>', methods=['PUT'])
def update_category(category_id):
    category = Category.query.get(category_id)

    if not category:
        return jsonify({'error': 'Category not found'}), 404

    new_name = request.json.get('name')

    if not new_name:
        return jsonify({'error': 'New name is required'}), 400

    category.name = new_name
    db.session.commit()

    return jsonify({'message': 'Category updated successfully', 'category': category.name})

@category_blueprint.route('/categories/<int:category_id>', methods=['DELETE'])
def delete_category(category_id):
    category = Category.query.get(category_id)

    if not category:
        return jsonify({'error': 'Category not found'}), 404

    db.session.delete(category)
    db.session.commit()

    return jsonify({'message': 'Category deleted successfully'})