import 'package:flutter/material.dart';
import 'package:openhms/core/widgets/text_checkbox.dart';
import 'package:openhms/core/widgets/title_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.background,
      body: Column(
        children: [
          const TitleBar(),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                width: w / 2,
                height: h - 40,
                child: const Image(
                    image: AssetImage('assets/hotel.png'), fit: BoxFit.fill),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height - 40,
                color: theme.surface,
                child: UnconstrainedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: SizedBox(
                      width: w * 0.3 < 550 ? w * 0.3 : 550,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WelcomeText(theme: theme),
                          const SizedBox(height: 64),
                          SsoButton(w: w, h: h, theme: theme),
                          const Divider(height: 45.0),
                          UsernameTextField(theme: theme),
                          const SizedBox(height: 30),
                          PasswordTextField(theme: theme),
                          const SizedBox(height: 20),
                          const CheckboxWithText(text: 'Remember me'),
                          const SizedBox(height: 20),
                          LoginButton(w: w, h: h, theme: theme)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.w,
    required this.h,
    required this.theme,
  }) : super(key: key);

  final double w;
  final double h;
  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w * 0.9,
      height: h * 0.065,
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(theme.background),
          overlayColor:
              MaterialStateProperty.all(theme.secondary.withOpacity(0.3)),
          side: MaterialStateProperty.all(BorderSide(
            color: theme.outline,
            width: 2.0,
            style: BorderStyle.solid,
          )),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
        ),
        child: Text(
          'Log in',
          style: TextStyle(
              color: theme.onSurface,
              fontSize: 27,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SsoButton extends StatelessWidget {
  const SsoButton({
    Key? key,
    required this.w,
    required this.h,
    required this.theme,
  }) : super(key: key);

  final double w;
  final double h;
  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    double height = h * 0.045;
    return SizedBox(
      width: w * 0.3,
      height: height.clamp(0, 55),
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Image.asset(
          'assets/sso.png',
          color: theme.onSurface,
          scale: w * 0.3 < 500.0 ? 1 : 0.8,
        ),
        label: Text(
          'Login with SSO',
          style: TextStyle(
              color: theme.onSurface,
              fontSize: w * 0.3 < 500 ? 21.0 : 28,
              fontWeight: FontWeight.normal),
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
              BorderSide(color: theme.outline, width: 2.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          overlayColor:
              MaterialStateProperty.all(theme.secondary.withOpacity(0.3)),
        ),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      children: [
        TextSpan(
          text: 'Welcome back,\n',
          style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
              color: theme.onSurface),
        ),
        TextSpan(
          text: 'Please enter your details',
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
              color: theme.onSurface),
        )
      ],
    ));
  }
}

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: theme.onSurface, fontSize: 15),
      decoration: textFieldDecoration(theme, 'Username'),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      style: TextStyle(color: theme.onSurface, fontSize: 15),
      decoration: textFieldDecoration(theme, 'Password'),
    );
  }
}

textFieldDecoration(theme, hintText) => InputDecoration(
      filled: true,
      fillColor: theme.primary.withOpacity(0.5),
      hintText: hintText,
      hintStyle: TextStyle(color: theme.onSurface, fontSize: 15.0),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: theme.outline, width: 2.0, style: BorderStyle.solid)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: theme.outline, width: 2.0, style: BorderStyle.solid)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: theme.secondary, width: 2.0, style: BorderStyle.solid)),
    );
