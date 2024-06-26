from flask import Blueprint, request, jsonify
from utils.database import db
from models import BillDetails

bill_details_blueprint = Blueprint('bill_details_controller', __name__)

@bill_details_blueprint.route('/bill-details', methods=['POST'])
def create_bill_detail():
    data = request.json
    bill_id = data.get('bill_id')
    product_id = data.get('product_id')
    quantity = data.get('quantity')

    if not all([bill_id, product_id, quantity]):
        return jsonify({'error': 'All fields are required'}), 400

    bill_detail = BillDetails(bill_id=bill_id, product_id=product_id, quantity=quantity)
    db.session.add(bill_detail)
    db.session.commit()

    return jsonify({'message': 'Bill detail created successfully', 'bill_detail': {
        'id': bill_detail.id,
        'bill_id': bill_detail.bill_id,
        'product_id': bill_detail.product_id,
        'quantity': bill_detail.quantity
    }}), 201

@bill_details_blueprint.route('/bill-details', methods=['GET'])
def get_bill_details():
    bill_details = BillDetails.query.all()
    bill_details_list = [{
        'id': bill_detail.id,
        'bill_id': bill_detail.bill_id,
        'product_id': bill_detail.product_id,
        'quantity': bill_detail.quantity
    } for bill_detail in bill_details]
    return jsonify(bill_details_list)

@bill_details_blueprint.route('/bill-details/<int:bill_detail_id>', methods=['GET'])
def get_bill_detail(bill_detail_id):
    bill_detail = BillDetails.query.get(bill_detail_id)

    if not bill_detail:
        return jsonify({'error': 'Bill detail not found'}), 404

    return jsonify({
        'id': bill_detail.id,
        'bill_id': bill_detail.bill_id,
        'product_id': bill_detail.product_id,
        'quantity': bill_detail.quantity
    })

@bill_details_blueprint.route('/bill-details/<int:bill_detail_id>', methods=['PUT'])
def update_bill_detail(bill_detail_id):
    bill_detail = BillDetails.query.get(bill_detail_id)

    if not bill_detail:
        return jsonify({'error': 'Bill detail not found'}), 404

    data = request.json
    bill_detail.bill_id = data.get('bill_id', bill_detail.bill_id)
    bill_detail.product_id = data.get('product_id', bill_detail.product_id)
    bill_detail.quantity = data.get('quantity', bill_detail.quantity)

    db.session.commit()

    return jsonify({'message': 'Bill detail updated successfully', 'bill_detail': {
        'id': bill_detail.id,
        'bill_id': bill_detail.bill_id,
        'product_id': bill_detail.product_id,
        'quantity': bill_detail.quantity
    }})

@bill_details_blueprint.route('/bill-details/<int:bill_detail_id>', methods=['DELETE'])
def delete_bill_detail(bill_detail_id):
    bill_detail = BillDetails.query.get(bill_detail_id)

    if not bill_detail:
        return jsonify({'error': 'Bill detail not found'}), 404

    db.session.delete(bill_detail)
    db.session.commit()

    return jsonify({'message': 'Bill detail deleted successfully'})
