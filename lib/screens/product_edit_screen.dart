// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_is_empty, unused_local_variable, deprecated_member_use, unnecessary_new, avoid_print



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productsService.productoSeleccionado),
      child: _ProductEditScreenBody(productsService: productsService),
    );
    //  return
  }
}

class _ProductEditScreenBody extends StatelessWidget {
  const _ProductEditScreenBody({
    Key? key,
    required this.productsService,
  }) : super(key: key);

  final ProductsService productsService;

  @override
  Widget build(BuildContext context) {
    /*Se creo esto para actualizar los productos*/
      final productForm = Provider.of<ProductFormProvider>(context);

    /*Para hacer lo de arriba se extrajo el widget con ctrl r */
    return Scaffold(
      /*se agrega para hacer el scroll a pantalla*/
      body: SingleChildScrollView(
        /*Esto es para cuando se haga scroll se oculte el texto*/
       // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                /*De esta manera tomamos la imagen que llega del producto seleccionado*/
                ProductEditImage(
                    url: productsService.productoSeleccionado.picture),
                /*Para agregar los iconos arriba de la card de edit*/
                Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon:
                          Icon(Icons.arrow_back, size: 40, color: Colors.black),
                    )),
                /*Para agregar los iconos arriba de la card de edit*/
                Positioned(
                    top: 50,
                    left: 300,
                    child: IconButton(
                      onPressed: () async {
                        /*Icono de Camaras o galeria*/

                        final picker = new ImagePicker();
                        final PickedFile? pickedFile = await picker.getImage(
                          /*Para cambiar camara o galleria*/
                          source: ImageSource.camera,
                          imageQuality: 100);

                        if(pickedFile == null){
                          print('No se selecciono ninguna foto');
                          return;
                        }
                        print('Tenemos imagen ${pickedFile.path}');
                        
                        /*Con esto agregamos imagen al app en el mostrador*/
                        productsService.actualizarImagenProductoSeleccionado(pickedFile.path);

                      },
                      icon: Icon(Icons.camera_alt_outlined,
                          size: 40, color: Colors.black),
                    ))
              ],
            ),
            _FormularioProducto()

            
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        child: productsService.estaGuardado ? CircularProgressIndicator(color: Colors.white,) :  Icon(Icons.save_outlined),
        onPressed: 
        productsService.estaGuardado? null : ()  async {
          /*Guardar y actualizar el producto */

          if ( !productForm.estaValidoFormulario()) return;

          final String? imagenUrl= await productsService.subirImagenes();
          
          if (imagenUrl != null) productForm.product.picture = imagenUrl;

          await productsService.GuardarOCrearProductos(productForm.product);
         
        },
      ),
      
      
    
    );
  }
}


class _FormularioProducto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*Para enviar texto de api al formulario De esta manera tenemos la informacion del producto interno*/
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _FormularioBoxDecoration(),
        child: Form(
          /*poner key para poder actualizar */
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,


          child: Column(
            children: [
              SizedBox(height: 20),
              /*TEXTO NOMBRE*/
              TextFormField(
                  /*Mostrar valores del api y ponerlos en input text*/
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligatorio';
                  },
              decoration: InputDecorations.authInputDecoration(
              hintText: 'Nombre del producto', labelText: 'Nombre:')),
              SizedBox(height: 30),
              /*TEXTO PRECIO*/
              TextFormField(
                  /*Para que el teclado solo sera numerico*/
                  initialValue: '${product.price}',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}'))
                  ],
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      product.price = 0;
                    } else {
                      product.price = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '\$150.000', labelText: 'Precio:')),
              SizedBox(height: 20),
              /*Barra para de activacion switch*/
              SwitchListTile.adaptive(
                  value: product.available,
                  title: Text('Disponible'),
                  activeColor: Colors.indigo,
                  onChanged: productForm.actualizarDisponibilidad,      
              ),
              SizedBox(height: 10),
              IconButton(onPressed: _ButtonEliminar, icon: Icon(Icons.delete))

            ]
            ),
      ),
    ),
    );
  }

  void _ButtonEliminar(){
    print('Soy el boton xd');


  }

  BoxDecoration _FormularioBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5,
            )
          ]);


          
}
