import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';


class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({
    required this.message,
    required this.success,
  });
}

class StripeServices {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeServices.apiBase}/payment_intents';
  static Uri paymentApiUri = Uri.parse(paymentApiUrl);
  static String secret =
      'sk_test_51JVteWB1RkzO3mgmkETjSZc6KmAziOOrLLN5lECqbhe9gKTHQIIcFof826YBqcbxNsIfVbcmuCuzZEXfcZtmX73500vswpbc07';

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeServices.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
        'pk_test_51JVteWB1RkzO3mgmrYlVjNOfaaTqDjGJe2WgjsiO0jySkJeByKuk6vXAdPjE23CyHZkf9OGaUFztHh3nTY8zYKoT00exH9EBv3',
        androidPayMode: 'test',
        merchantId: 'test'));
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response =
      await http.post(paymentApiUri, headers: headers, body: body);
      return jsonDecode(response.body);
    } catch (error) {
      print('error Happened');
      throw error;
    }
  }

  static Future<StripeTransactionResponse> payNowHandler(
      {required String amount, required String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
      await StripeServices.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));

      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } catch (error) {
      return StripeTransactionResponse(
          message: 'Transaction failed in the catch block', success: false);
    } on PlatformException catch (error) {
      return StripeServices.getErrorAndAnalyze(error);
    }
  }

  static getErrorAndAnalyze(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction canceled';
    }
    return StripeTransactionResponse(message: message, success: false);
  }
}



/*
class StripeTransactionResponse {
  String? message;
  bool? success;
  StripeTransactionResponse({required this.message, required this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static Uri paymentApiUri = Uri.parse(paymentApiUrl);
  static String secret =
      'sk_test_51IybLKAW5XQBJRRQle5jA6kFuQVujWfugyTsnkedVjWB7bRtTSGKQ6l7SO4QLgvg7RgJY07uILVutwTXE70G9yYC00N1RtFB51';

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
        'pk_test_51IybLKAW5XQBJRRQZdW4WIxaX6g23LLvG9kZCiiSWEurPy2WvS0r7IZ9iNzoI9Er75BQT2oF4UBS7XXbM9DMlEui00t2kuCkyn',
        merchantId: 'test',
        androidPayMode: 'test'));
  }

  static Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {"amount": amount, "currency": currency};
      var response =
      await http.post(paymentApiUri, headers: headers, body: body);
      return jsonDecode(response.body);
    } catch (error) {
      print('error occured in the payment intent $error ');
    }
    return null;
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String? amount, String? currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
      await StripeService.createPaymentIntent(amount!, currency!);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent!['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (error) {
      return StripeService.getPlatformExceptionErrorResult(error);
    } catch (error) {
      return StripeTransactionResponse(
          message: 'Transaction failed : $error', success: false);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }
}


 */

/*
class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({required this.message, required this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static Uri paymentApiUri = Uri.parse(paymentApiUrl);
  static String secret =
      'sk_test_51IybLKAW5XQBJRRQle5jA6kFuQVujWfugyTsnkedVjWB7bRtTSGKQ6l7SO4QLgvg7RgJY07uILVutwTXE70G9yYC00N1RtFB51';

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
        'pk_test_51JVteWB1RkzO3mgmrYlVjNOfaaTqDjGJe2WgjsiO0jySkJeByKuk6vXAdPjE23CyHZkf9OGaUFztHh3nTY8zYKoT00exH9EBv3',
        merchantId: 'test',
        androidPayMode: 'test'));
  }

  static Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {"amount": amount, "currency": currency};
      var response =
      await http.post(paymentApiUri, headers: headers, body: body);
      return jsonDecode(response.body);
    } catch (error) {
      print('error occured in the payment intent $error ');
    }
    return null;
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String? amount, String? currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
      await StripeService.createPaymentIntent(amount!, currency!);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent!['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (error) {
      return StripeService.getPlatformExceptionErrorResult(error);
    } catch (error) {
      return StripeTransactionResponse(
          message: 'Transaction failed : $error', success: false);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }
}


 */