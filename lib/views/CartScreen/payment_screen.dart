import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/views/CartScreen/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../utils/colors.dart';

class PaymentGetewayScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cardData;
  final double totalAmount;

  const PaymentGetewayScreen({super.key, required this.cardData, required this.totalAmount});

  @override
  State<PaymentGetewayScreen> createState() => _PaymentGetewayScreenState();
}

class _PaymentGetewayScreenState extends State<PaymentGetewayScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final color = Colors.black; // Replace with themeManager logic if necessary
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            InkWell(
              onTap: () => initiateBkashPayment(context),
              child: Card(
                color: AppColor.fieldBackgroundColor,
                child: ListTile(
                  title: Text(
                    "bKash",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: color,
                    ),
                  ),
                  trailing: Text(
                    "৳${widget.totalAmount.toString()}",
                    style: TextStyle(fontSize: 16, color: color),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => cashOnDelivery(),
              child: Card(
                color: AppColor.fieldBackgroundColor,
                child: ListTile(
                  title: Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: color,
                    ),
                  ),
                  trailing: Text(
                    "৳${widget.totalAmount.toString()}",
                    style: TextStyle(fontSize: 16, color: color),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initiateBkashPayment(BuildContext context) async {
    final flutterBkash = FlutterBkash();

    try {
      final result = await flutterBkash.pay(
        context: context,
        amount: widget.totalAmount,
        merchantInvoiceNumber: "INV123456", // Replace with your invoice ID
      );

      dev.log('Payment Success: $result');

      // Save the order to Firebase Firestore
      await saveOrder("bKash");

      // Navigate to Cart Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CartScreen()),
      );

      // Show success message
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(message: "Payment Successful!"),
      );
    } on BkashFailure catch (e) {
      dev.log('Payment Failed: $e');

      // Show error message
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: "Payment Failed: ${e.message}"),
      );
    } catch (e) {
      dev.log('Unexpected Error: $e');

      // Show generic error message
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: "An unexpected error occurred."),
      );
    }
  }

  Future<void> saveOrder(String paymentMethod) async {
    final orderDoc = FirebaseFirestore.instance
        .collection("orders")
        .doc(user!.email)
        .collection("order")
        .doc();

    await orderDoc.set({
      'id': orderDoc.id,
      'email': user!.email,
      'item': widget.cardData,
      'amount': widget.totalAmount,
      'gtName': paymentMethod,
      'delivery': true,
    });

    // Clear the cart after successful payment
    final cart = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.email)
        .collection('cart')
        .get();

    for (var item in cart.docs) {
      await item.reference.delete();
    }
  }

  void cashOnDelivery() async {
    await saveOrder("COD");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CartScreen()),
    );
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: "Order Placed Successfully!"),
    );
  }
}
