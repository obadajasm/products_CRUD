import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passValue;
  bool _acceptTerms = false;
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
              child: Column(
                children: <Widget>[
                  TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          _emailValue = value;
                        });
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _passValue = value;
                        });
                      }),
                  SwitchListTile(
                    title: Text(
                      'ACCEPT ME :( ',
                    ),
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = !_acceptTerms;
                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                    child: Text('LOGIN'),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/s');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
