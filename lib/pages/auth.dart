import 'package:flutter/material.dart';
import 'package:mx_crud/scoped-models/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': null,
  };
  bool _acceptTerms = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(Function login) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    login(_formData['email'], _formData['password']);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deiceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deiceWidth > 556 ? 500 : deiceWidth * 0.95;
    return Scaffold(
      appBar: AppBar(
        title: Text('LOG IN'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage("assets/bg.jpg"),
          ),
        ),
        padding: EdgeInsets.all(32),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (s) {
                          if (!s.contains("@"))
                            return 'please Endter a Valid Email';
                        },
                        onSaved: (value) {
                          _formData['email'] = value;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                        onSaved: (value) {
                          _formData['password'] = value;
                        }),
                    SwitchListTile(
                      title: Text(
                        'ACCEPT ME :( ',
                      ),
                      value: _acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptTerms = value;
                          _formData['acceptTerms'] = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (context, _, model) {
                        return RaisedButton(
                          child: Text('LOGIN'),
                          onPressed: () {
                            _submitForm(model.login);
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
