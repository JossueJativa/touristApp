from utils.database import db

class BillDetails(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    bill_id = db.Column(db.Integer, db.ForeignKey('bill_header.id'), nullable=False)
    product_id = db.Column(db.Integer, db.ForeignKey('product.id'), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)

    def __repr__(self):
        return {
            'id': self.id,
            'bill_id': self.bill_id,
            'product_id': self.product_id,
            'quantity': self.quantity
       }