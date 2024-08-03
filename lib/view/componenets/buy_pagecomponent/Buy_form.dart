import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/view/componenets/buy_pagecomponent/Buy_pagecomp.dart';
import 'package:flutter_application_8/view/componenets/my_textfield.dart';
import 'package:provider/provider.dart';

class BuyForm extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onCheckout;

  BuyForm({required this.totalPrice, required this.onCheckout});

  static final _formKey = GlobalKey<FormState>();
  static final _nameController = TextEditingController();
  static final _phoneController = TextEditingController();
  static final _emailController = TextEditingController();
  static final _addressController = TextEditingController();
  static final _pincodeController = TextEditingController();
  static final _stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
                return ListTile(
                  leading: Image.network(item.imageUrl),
                  title: Text(item.artistName),
                  subtitle: Text('Art Name: ${item.name} - Price: \$${item.price.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Text('Total Price: \$${cartProvider.totalPrice.toStringAsFixed(2)}'),
          BuyField(
            hinttexxt: 'Name',
            obs: false,
            textcont: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          BuyField(
            hinttexxt: 'Phone Number',
            obs: false,
            textcont: _phoneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          BuyField(
            hinttexxt: 'Email',
            obs: false,
            textcont: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          BuyField(
            hinttexxt: 'Address',
            obs: false,
            textcont: _addressController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          BuyField(
            hinttexxt: 'State',
            obs: false,
            textcont: _stateController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your state';
              }
              return null;
            },
          ),
          BuyField(
            hinttexxt: 'Pincode',
            obs: false,
            textcont: _pincodeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your pincode';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _formKey.currentState != null && _formKey.currentState!.validate()
                ? onCheckout
                : null,
            child: const Text('Place Order'),
          ),
        ],
      ),
    );
  }
}
