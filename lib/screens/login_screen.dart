// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, unused_element, non_constant_identifier_names, unnecessary_new, unused_local_variable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*De esta manera puedo llamar al widget de autenticacion para hacer cambios mas rapido*/
        body: Authbackground(
            /*Scroll permite hacer scroll si los hijos no tenga espacio y alli queramos ahcer el scroll*/
            child: SingleChildScrollView(
      child: Column(
        children: [
          /*Para darle tamaño ala caja que se va a usar parar el CARD*/

          SizedBox(
            height: 150,
          ),
          /*Aca va todo lo que va dentro del Card*/
          CardContainer(
              child: Column(
            children: [
              /*Centramos lo que vamos a utilizar dentro del card*/
              SizedBox(height: 10),
              /*Stilo para el texto LOGIN*/
              Text("Login", style: Theme.of(context).textTheme.headline4),
              SizedBox(
                height: 12,
              ),
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: _FormulariosLogin(),
              ),
            ],
          )),
          SizedBox(
            height: 50,
          ),
          Text(
            "Crear nueva cuenta",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    )));
  }
}

/*
;*/
class _FormulariosLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*Con este final puedo obtener todo lo de clase form provider de login*/
    final FormularioLogin = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
     
        /*Validacion para cuando le demos ingresar y no tengamos nada en los formsfields*/
        key: FormularioLogin.formKey,

        /*Para validar los formularios*/
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              /*Aca llamamos la clase que esta en ui/inputdecoration para que salga sus respectivos estilos */
              decoration: InputDecorations.authInputDecoration(
                /*Se ponen los argumentos del inputs decorations aca*/
                hintText: 'manuel.a@gmail.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_rounded,
              ),
              onChanged: (value) => FormularioLogin.email = value,
              /*Para validar formularios*/
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Verifica bien el correo ';
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              autocorrect: false,
              /*Para que no se vean las contraseñas */
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              /*Aca llamamos la clase que esta en ui/inputdecoration para que salga sus respectivos estilos */
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*************',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              /*Para validar formularios contraseñas*/
              onChanged: (value) => FormularioLogin.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña tiene que ser de 6 digitos';
              },
            ),
            SizedBox(height: 10),
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    /* Para que salga que esta cargando cuando se le de el botton ingresar */
                    FormularioLogin.estaCargando ? 'Espere...' : 'Ingresar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: 
                /* Con esto esperara 2 segundo de carga */FormularioLogin.estaCargando
                    ? null
                    : () async {
                        /*Quitar teclado*/
                        FocusScope.of(context).unfocus();

                        /*si lo que llega al form esta malo no hace nada*/
                        if (!FormularioLogin.esValidoFormulario()) return;

                        /*Para que salga que esta cargando cuando se da click al boton ingresar*/
                        FormularioLogin.estaCargando = true;
                         /* Con esto esperara 2 segundo de carga */
                        await Future.delayed(Duration(seconds: 2));

                        //Validar si el login es correcto
                        FormularioLogin.estaCargando=false;

                        Navigator.pushReplacementNamed(context, 'home');
                      }),
          ],
        ),
      ),
    );
  }
}
