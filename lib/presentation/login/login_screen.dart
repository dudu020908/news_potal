import 'package:easy_extension/easy_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:news_potal/api/auth_api.dart';
import 'package:news_potal/app/router/app_router.dart';
import 'package:news_potal/app/translations/app_trans.dart';
import 'package:news_potal/presentation/common/app_scaffold.dart';
import 'package:news_potal/widgets/app_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    //미리 선언
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() async {
    // 해야할것 이메일 패스워드 가져오기
    final email = _emailController.text;
    final password = _passwordController.text;
    debugPrint('이메일: $email');
    debugPrint('패스워드: $password');

    AuthApi.login(email: email, password: password);
    final auth = await AuthApi.login(email: email, password: password);
    if (auth == null) {
      return;
    }
    if (!mounted) {
      return;
    }
    context.goNamed(AppRoute.newsList.name);
  }

  TextField _textField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }

  OutlinedButton _buildSsoButton(String sso) {
    final logoUrl = {
      'Google':
          'https://daelim-doc.fleecy.dev/raiz5jee8eiph0eeFooV/api/v1/projects/866715/resources/354903/image-preview?onlineShareType=apidoc&locale=en-US',
      'Apple':
          'https://daelim-doc.fleecy.dev/raiz5jee8eiph0eeFooV/api/v1/projects/866715/resources/354902/image-preview?onlineShareType=apidoc&locale=en-US',
    };
    return OutlinedButton(
      onPressed: () {},
      child: Row(
        children: [
          Image.network(
            logoUrl[sso] ?? '',
            errorBuilder: (context, error, stackTrace) {
              return Icon(LucideIcons.x, size: 24);
            },
          ),

          Expanded(
            child: Center(
              child: Text(
                AppTrans.login.signInWith.tr(namedArgs: {'sso': sso}),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppLogo(),
            Container(
              height: 150,
              alignment: Alignment.center,
              child: Text(
                AppTrans.login.welcome.tr(),
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
            ),
            _textField(
              controller: _emailController,
              hintText: AppTrans.login.email.tr(),
            ),
            20.heightBox,
            _textField(
              controller: _passwordController,
              hintText: AppTrans.login.password.tr(),
            ),
            20.heightBox,
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: _onLogin,
                child: Text(AppTrans.login.login.tr()),
              ),
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: Row(
                spacing: 10,
                children: [
                  Expanded(child: Divider()),
                  Text(AppTrans.login.orUse.tr()),
                  Expanded(child: Divider()),
                ],
              ),
            ),
            10.heightBox,
            _buildSsoButton('Google'),
            _buildSsoButton('Apple'),
          ],
        ),
      ),
    );
  }
}
