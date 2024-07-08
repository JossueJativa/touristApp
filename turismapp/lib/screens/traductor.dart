import 'package:flutter/material.dart';
import 'package:turismapp/components/ButtonForm.dart';
import 'package:turismapp/components/DropdownButton.dart';
import 'package:turismapp/components/TextArea.dart';
import 'package:turismapp/controller/translate.dart';
import 'package:turismapp/mainScaffold.dart';

class Traductor extends StatefulWidget {
  const Traductor({Key? key}) : super(key: key);

  @override
  _TraductorState createState() => _TraductorState();
}

class _TraductorState extends State<Traductor> {
  final Map<String, String> _languages = {
    "es": "Español",
    "en": "Inglés",
    "fr": "Francés",
    "de": "Alemán",
    "it": "Italiano",
    "pt": "Portugués"
  };
  final TextEditingController _textToTranslate = TextEditingController();
  final TextEditingController _translatedText = TextEditingController();

  String _sourceLanguage = 'es';
  String _targetLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background_login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextArea(controller: _textToTranslate, editable: true,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomDropdownButton(
                      value: _sourceLanguage,
                      items: _languages,
                      onChanged: (String? value) {
                        setState(() {
                          _sourceLanguage = value!;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.compare_arrows),
                      onPressed: () {
                        final String temp = _sourceLanguage;
                        setState(() {
                          _sourceLanguage = _targetLanguage;
                          _targetLanguage = temp;
                        });
                      },
                    ),
                    CustomDropdownButton(
                      value: _targetLanguage,
                      items: _languages,
                      onChanged: (String? value) {
                        setState(() {
                          _targetLanguage = value!;
                        });
                      },
                    ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonForm(
                    text: 'Traducir',
                    onPressed: () async {
                      _translatedText.text = 'Traduciendo...';
                      final String translated = await translate(_textToTranslate.text, _sourceLanguage, _targetLanguage);
                      _translatedText.text = "";
                      setState(() {
                        _translatedText.text = translated;
                      });
                    },
                    principalColor: const Color(0xFF80DEEA),
                    onPressedColor: const Color(0xFF4DB6AC),
                    textColor: Colors.black,
                    key: const Key('translateButton'),
                  ),
                ),
                
                TextArea(controller: _translatedText, editable: false,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
