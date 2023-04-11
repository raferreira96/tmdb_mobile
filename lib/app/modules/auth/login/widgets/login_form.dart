part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final controller = Modular.get<LoginController>();

  @override
  void dispose() {
    _usernameEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          CustomTextFormField(
              label: 'Usuário',
              controller: _usernameEC,
              validator: Validatorless.required('Campo obrigatório!')),
          const SizedBox(height: 20),
          CustomTextFormField(
            label: 'Senha',
            obscureText: true,
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required('Campo obrigatório!'),
              Validatorless.min(6, 'Senha precisa conter mais de 6 caracteres!')
            ]),
          ),
          const SizedBox(height: 20),
          CustomDefaultButton(
              label: 'Entrar',
              onPressed: () async {
                final formValid = _formKey.currentState?.validate() ?? false;
                if (formValid) {
                  await controller.login(_usernameEC.text, _passwordEC.text);
                }
              })
        ]));
  }
}
