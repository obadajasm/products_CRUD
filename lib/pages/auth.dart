import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mx_crud/scoped-models/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

enum AuthMode { Signup, Login }

class AuthPage extends StatefulWidget {
  final MainModel mainModel;
  AuthPage(this.mainModel);

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
  final TextEditingController passwordEditingController =
      TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  void _submitForm() async {
    String message;
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (_authMode == AuthMode.Signup)
      message = await widget.mainModel
          .signUp(_formData['email'], _formData['password']);
    else if (_authMode == AuthMode.Login)
      message = await widget.mainModel
          .signIn(_formData['email'], _formData['password']);

    if (message == 'done')
      Navigator.pushReplacementNamed(context, '/products');
    else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Oops"),
              content: Text(message),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deiceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deiceWidth > 556 ? 500 : deiceWidth * 0.95;
    return Scaffold(
      appBar: AppBar(
        title: Text('${_authMode == AuthMode.Login ? 'LOG IN' : 'Sign up'}'),
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
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildPasswordTextField(),
                    _authMode == AuthMode.Signup
                        ? _buildConfirmPasswordTextField()
                        : Container(),
                    _buildAcceptSwitch(),
                    SizedBox(
                      height: 16,
                    ),
                    FlatButton(
                      child: Text(
                          'Switch to ${_authMode == AuthMode.Login ? 'Sign up' : 'Login'}'),
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.Login
                              ? AuthMode.Signup
                              : AuthMode.Login;
                        });
                      },
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (context, _, model) {
                        return RaisedButton(
                          child: Text(
                              '${_authMode == AuthMode.Login ? 'LOG IN' : 'Sign up'}'),
                          onPressed: () {
                            _submitForm();
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

  SwitchListTile _buildAcceptSwitch() {
    return SwitchListTile(
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
    );
  }

  TextFormField _buildConfirmPasswordTextField() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'Confirm - Password',
          filled: true,
          fillColor: Colors.white,
        ),
        obscureText: true,
        validator: (String s) {
          if (passwordEditingController.text != s) {
            return 'Passwords not match';
          }
        },
        onSaved: (value) {
          _formData['password'] = value;
        });
  }

  TextFormField _buildPasswordTextField() {
    return TextFormField(
        controller: passwordEditingController,
        decoration: InputDecoration(
          labelText: 'Password',
          filled: true,
          fillColor: Colors.white,
        ),
        obscureText: true,
        onSaved: (value) {
          _formData['password'] = value;
        });
  }

  TextFormField _buildEmailTextField() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (s) {
          if (!s.contains("@")) return 'please Endter a Valid Email';
        },
        onSaved: (value) {
          _formData['email'] = value;
        });
  }
}
