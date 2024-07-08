from flask import Blueprint, request, jsonify
from utils.database import db
from models import BillHeader
from datetime import datetime

bill_header_blueprint = Blueprint('bill_controller', __name__)

@bill_header_blueprint.route('/bills', methods=['POST'])
def create_bill():
    data = request.json
    date_str = data.get('date')
    total = data.get('total')
    user_id = data.get('user_id')
    first_name = data.get('first_name')
    last_name = data.get('last_name')
    email = data.get('email')
    location = data.get('location')
    phone = data.get('phone')

    if not all([date_str, total, user_id, first_name, last_name, email, location, phone]):
        return jsonify({'error': 'All fields are required'}), 400

    try:
        # Convierte la cadena de texto a un objeto date de Python
        date = datetime.strptime(date_str, '%Y-%m-%d %H:%M:%S.%f').date()
    except ValueError:
        return jsonify({'error': 'Date format is incorrect'}), 400

    bill = BillHeader(date=date, total=total, user_id=user_id, first_name=first_name,
                      last_name=last_name, email=email, location=location, phone=phone)
    db.session.add(bill)
    db.session.commit()

    return jsonify({'message': 'Bill created successfully', 'bill': {
        'id': bill.id,
        'date': str(bill.date),
        'total': bill.total,
        'user_id': bill.user_id,
        'first_name': bill.first_name,
        'last_name': bill.last_name,
        'email': bill.email,
        'location': bill.location,
        'phone': bill.phone
    }}), 201

@bill_header_blueprint.route('/bills', methods=['GET'])
def get_bills():
    bills = BillHeader.query.all()
    bills_list = [{
        'id': bill.id,
        'date': str(bill.date),
        'total': bill.total,
        'user_id': bill.user_id,
        'first_name': bill.first_name,
        'last_name': bill.last_name,
        'email': bill.email,
        'location': bill.location,
        'phone': bill.phone
    } for bill in bills]
    return jsonify(bills_list)

@bill_header_blueprint.route('/bills/<int:bill_id>', methods=['GET'])
def get_bill(bill_id):
    bill = BillHeader.query.get(bill_id)

    if not bill:
        return jsonify({'error': 'Bill not found'}), 404

    return jsonify({
        'id': bill.id,
        'date': str(bill.date),
        'total': bill.total,
        'user_id': bill.user_id,
        'first_name': bill.first_name,
        'last_name': bill.last_name,
        'email': bill.email,
        'location': bill.location,
        'phone': bill.phone
    })

@bill_header_blueprint.route('/bills/<int:bill_id>', methods=['PUT'])
def update_bill(bill_id):
    bill = BillHeader.query.get(bill_id)

    if not bill:
        return jsonify({'error': 'Bill not found'}), 404

    data = request.json
    bill.date = data.get('date', bill.date)
    bill.total = data.get('total', bill.total)
    bill.user_id = data.get('user_id', bill.user_id)
    bill.first_name = data.get('first_name', bill.first_name)
    bill.last_name = data.get('last_name', bill.last_name)
    bill.email = data.get('email', bill.email)
    bill.location = data.get('location', bill.location)
    bill.phone = data.get('phone', bill.phone)

    db.session.commit()

    return jsonify({'message': 'Bill updated successfully', 'bill': {
        'id': bill.id,
        'date': str(bill.date),
        'total': bill.total,
        'user_id': bill.user_id,
        'first_name': bill.first_name,
        'last_name': bill.last_name,
        'email': bill.email,
        'location': bill.location,
        'phone': bill.phone
    }})

@bill_header_blueprint.route('/bills/<int:bill_id>', methods=['DELETE'])
def delete_bill(bill_id):
    bill = BillHeader.query.get(bill_id)

    if not bill:
        return jsonify({'error': 'Bill not found'}), 404

    db.session.delete(bill)
    db.session.commit()

    return jsonify({'message': 'Bill deleted successfully'})