import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_3/providers/login_form_provider.dart';
import 'package:prueba_3/services/auth_service.dart';
import 'package:prueba_3/theme/my_theme.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: const RegisterForm(),
              ),
              const SizedBox(height: 30),
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                  style: ButtonStyle(
                    overlayColor:
                        WidgetStateProperty.all(Colors.indigo.withOpacity(0.1)),
                    shape: WidgetStateProperty.all(const StadiumBorder()),
                  ),
                  child: const Text('Ya tienes cuenta? Ingresa'))
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final RegisterForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: RegisterForm.formkey,
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
            onChanged: (value) => RegisterForm.email = value,
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
            onChanged: (value) => RegisterForm.password = value,
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: MyTheme.primary,
            elevation: 0,
            onPressed: RegisterForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!RegisterForm.isValidForm()) return;
                    RegisterForm.isLoading = true;
                    final String? errorMessage = await authService.createUser(
                        RegisterForm.email, RegisterForm.password);
                    if (errorMessage == null) {
                      Navigator.pushNamed(context, 'login');
                    } else {
                      print(errorMessage);
                    }
                    RegisterForm.isLoading = false;
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: const Text(
                'Crear',
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
