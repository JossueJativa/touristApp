from utils.database import db
from sqlalchemy import Date

class BillHeader(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    date = db.Column(Date, nullable=False)
    total = db.Column(db.Float, nullable=False)
    user_id = db.Column(db.Integer, nullable=False)
    first_name = db.Column(db.String(150), nullable=False)
    last_name = db.Column(db.String(150), nullable=False)
    email = db.Column(db.String(150), nullable=False)
    location = db.Column(db.String(150), nullable=False)
    phone = db.Column(db.String(150), nullable=False)

    def __repr__(self):
        return {
            'id': self.id,
            'date': self.date,
            'total': self.total,
            'user_id': self.user_id,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'email': self.email,
            'location': self.location,
            'phone': self.phone
        }