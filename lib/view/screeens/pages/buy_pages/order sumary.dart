import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/order_momdel.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/provider/orderprivedr.dart';

import 'package:flutter_application_8/view/componenets/buy_pagecomponent/order_summarycard.dart';
import 'package:flutter_application_8/view/screeens/pages/buy_pages/order_staus.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class OrderSummary extends StatelessWidget {
  final double totalPrice;
  final ValueNotifier<String> _nameNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> _phoneNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> _emailNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> _pincodeNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> _stateNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> _addressNotifier = ValueNotifier<String>('');

  OrderSummary({super.key, required this.totalPrice});

  void _handlePaymentSuccess(BuildContext context, PaymentSuccessResponse response) {
    final address = _addressNotifier.value;
    final orderId = response.paymentId!; // Assuming payment ID as order ID for this example

    final order = orderr(orderId: orderId, address: address);
    Provider.of<OrderProviderr>(context, listen: false).addOrder(order);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OrderStatusPage(orderId: orderId, address: address),
    ));
  }

  void _handlePaymentError(BuildContext context, PaymentFailureResponse response) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment Failed"),
        content: const Text("Something went wrong! Please try again."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _handleExternalWallet(BuildContext context, ExternalWalletResponse response) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("External Wallet"),
        content: Text("External Wallet selected: ${response.walletName}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _openCheckout(BuildContext context) {
    final razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) => _handlePaymentSuccess(context, response));
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) => _handlePaymentError(context, response));
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) => _handleExternalWallet(context, response));

    var options = {
      'key': 'rzp_test_VzSMZ0uUpAgbqc', // Replace with your Razorpay API key
      'amount': totalPrice * 100, // Amount in paisa (1 INR = 100 paisa)
      'name': 'Your App Name',
      'description': 'Order Payment',
      'prefill': {
        'contact': _phoneNotifier.value,
        'email': _emailNotifier.value,
      },
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Order Summary", style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _nameNotifier.value = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _phoneNotifier.value = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your phone number',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _emailNotifier.value = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _pincodeNotifier.value = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your pincode',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _stateNotifier.value = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your state',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _addressNotifier.value = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your address',
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            ValueListenableBuilder<String>(
              valueListenable: _nameNotifier,
              builder: (context, name, child) {
                return ValueListenableBuilder<String>(
                  valueListenable: _phoneNotifier,
                  builder: (context, phone, child) {
                    return ValueListenableBuilder<String>(
                      valueListenable: _emailNotifier,
                      builder: (context, email, child) {
                        return ValueListenableBuilder<String>(
                          valueListenable: _pincodeNotifier,
                          builder: (context, pincode, child) {
                            return ValueListenableBuilder<String>(
                              valueListenable: _stateNotifier,
                              builder: (context, state, child) {
                                return ValueListenableBuilder<String>(
                                  valueListenable: _addressNotifier,
                                  builder: (context, address, child) {
                                    return OrderSummarycard(
                                      price: cartProvider.totalPrice.toString(),
                                      ontap: name.isNotEmpty &&
                                              phone.isNotEmpty &&
                                              email.isNotEmpty &&
                                              pincode.isNotEmpty &&
                                              state.isNotEmpty &&
                                              address.isNotEmpty
                                          ? () => _openCheckout(context)
                                          : null,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
