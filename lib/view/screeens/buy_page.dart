import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/order_momdel.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/provider/locationprovider.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application_8/provider/order_provider.dart';


class BuyPage extends StatelessWidget {
  final double totalPrice;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final Razorpay _razorpay = Razorpay();

  BuyPage({Key? key, required this.totalPrice}) : super(key: key) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response, BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);

    final order = Order(
      items: cartProvider.items,
      totalPrice: cartProvider.totalPrice,
      name: _nameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      address: _addressController.text,
      location: locationProvider.location,
      id: response.orderId ?? '',
    );
    orderProvider.placeOrder(order);
    cartProvider.clearCart();
    Navigator.pushNamed(context, '/orderConfirmation');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment failed: ${response.message}');
    // Handle payment failure
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External wallet: ${response.walletName}');
    // Handle external wallet
  }

  void _openCheckout(BuildContext context) async {
    var options = {
      'key': 'rzp_test_VzSMZ0uUpAgbqc',
      'amount': totalPrice * 100, // Amount in paise
      'name': 'Your Company Name',
      'description': 'Payment for items in cart',
      'prefill': {
        'contact': _phoneController.text,
        'email': _emailController.text,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    _razorpay.open(options);
  }

  void _openMap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400,
          child: Consumer<LocationProvider>(
            builder: (context, locationProvider, child) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: locationProvider.pickedLocation ?? LatLng(37.7749, -122.4194),
                  zoom: 12,
                ),
                onMapCreated: (controller) {},
                onTap: (LatLng location) {
                  locationProvider.pickLocation(location);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    subtitle: Text(
                        'Art Name: ${item.name} - Price: \$${item.price.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            Text('Total Price: \$${cartProvider.totalPrice.toStringAsFixed(2)}'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: TextEditingController(text: locationProvider.location),
              decoration: const InputDecoration(labelText: 'Location'),
              readOnly: true,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      locationProvider.getCurrentLocation();
                    },
                    child: const Text('Get Current Location'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _openMap(context);
                    },
                    child: const Text('Pick Location on Map'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _openCheckout(context);
              },
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
