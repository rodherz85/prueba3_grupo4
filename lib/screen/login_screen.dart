import 'package:provider/provider.dart';
import 'package:prueba_3/providers/login_form_provider.dart';
import 'package:prueba_3/services/auth_service.dart';
import 'package:prueba_3/theme/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChangeNotifierProvider(
              create: (_) => LoginFormProvider(),
              child: const LoginForm(),
            ),
            const SizedBox(height: 30),
            TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'add_user'),
                style: ButtonStyle(
                  overlayColor:
                      WidgetStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: WidgetStateProperty.all(const StadiumBorder()),
                ),
                child: const Text('No tienes cuenta? Regístrate'))
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final Loginform = Provider.of<LoginFormProvider>(context);
    return Form(
      key: Loginform.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Ingrese su correo',
              labelText: 'Email',
              prefixIcon: const Icon(Icons.mail),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) => Loginform.email = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'El usuario no puede estar vacío';
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: '*******************',
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) => Loginform.password = value,
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: MyTheme.primary,
            elevation: 0,
            onPressed: Loginform.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!Loginform.isValidForm()) return;
                    Loginform.isLoading = true;
                    final String? errorMessage = await authService.login(
                        Loginform.email, Loginform.password);
                    if (errorMessage == null) {
                      Navigator.pushNamed(context, 'error');
                    } else {
                      print(errorMessage);
                    }
                    Loginform.isLoading = false;
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: const Text(
                'Ingresar',
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
