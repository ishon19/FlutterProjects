import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  bool isLoading;

  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid Email Address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      onSaved: (value) {
                        _userName = value;
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 4)
                          return 'Username must be of 4 characters';
                        return '';
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 6)
                        return 'Password must be of 6 characters';
                      return '';
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if(widget.isLoading) CircularProgressIndicator()
                  else RaisedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                  if(!widget.isLoading) FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin
                        ? 'Already have an account?'
                        : 'Create new account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
