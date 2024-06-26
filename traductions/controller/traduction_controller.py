from flask import Blueprint, request, jsonify
from googletrans import Translator, LANGUAGES

traduction_blueprint = Blueprint('traduction_controller', __name__)

@traduction_blueprint.route('/traduction', methods=['POST'])
def traduction():
    data = request.get_json()
    text = data.get('text')
    from_lan = data.get('from')
    to_lan = data.get('to')

    if not text or not to_lan:
        return jsonify({'error': 'Missing required parameters'}), 400

    if to_lan not in LANGUAGES.keys():
        return jsonify({'error': 'Invalid language code'}), 400

    translator = Translator()

    try:
        translated = translator.translate(text, src=from_lan, dest=to_lan)
        return jsonify({
            'old_text': text,
            'new_text': translated.text
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500
