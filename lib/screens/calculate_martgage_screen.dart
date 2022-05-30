import 'package:flutter/material.dart';
import 'package:flutter_martgage/domains/martdadecalculator.dart';
import 'package:flutter_martgage/screens/monthly_payment_screen.dart';

List<int> result = [];
var sumresult = Map<String, dynamic>();
bool paytypeIsDiff = true;

class CalculateMortgageScreen extends StatefulWidget {
  const CalculateMortgageScreen({Key? key}) : super(key: key);

  @override
  State<CalculateMortgageScreen> createState() =>
      _CalculateMortgageScreenState();
}

class _CalculateMortgageScreenState extends State<CalculateMortgageScreen> {
  final TextEditingController _sumContrtoller = TextEditingController();
  final TextEditingController _periodContrtoller = TextEditingController();
  final TextEditingController _percentContrtoller = TextEditingController();
  final TextEditingController _initsum = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Mortgage_Calculator example = Mortgage_Calculator();

  void calculate() {
    if (paytypeIsDiff) {
      example.typediff = true;
    } else {
      example.typediff = false;
    }
    double initsumparce = double.parse(_initsum.text);
    example.initialPayment = initsumparce;
    double percentparse = double.parse(_percentContrtoller.text);
    example.percent = percentparse;
    int periodparse = int.parse(_periodContrtoller.text);
    example.period = periodparse;
    double sumparse = double.parse(_sumContrtoller.text);
    example.sum = sumparse;
    result = example.calcul();
    sumresult = example.sumResult();
  }

  void navigateToPaymentScreen() {
    if (_formkey.currentState!.validate()) {
      calculate();
      Navigator.pushNamed(context, '/payment', arguments: paytypeIsDiff);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.short_text,
          size: 33,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          children: [
            const Center(
              child: Header(
                title1: 'Ипотечный',
                title2: 'Калькулятор',
                fontColor: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            const PaymentTypeButton(),
            const SizedBox(height: 12),
            TextFormFieldWidget(
                controller: _sumContrtoller, toptext: 'Стоимость недвижимости'),
            const SizedBox(
              height: 20,
            ),
            TextFormFieldWidget(
                controller: _initsum, toptext: 'Первоначальный взнос'),
            const SizedBox(
              height: 20,
            ),
            TextFormFieldWidget(
                controller: _periodContrtoller, toptext: 'Срок кредитования'),
            const SizedBox(
              height: 20,
            ),
            TextFormFieldWidget(
                controller: _percentContrtoller, toptext: 'Процентная ставка'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: BottonButton(
                buttontext: 'Вычислить',
                buttonPressed: navigateToPaymentScreen,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String toptext;
  const TextFormFieldWidget(
      {Key? key, required this.controller, required this.toptext})
      : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.toptext,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            focusColor: const Color.fromARGB(255, 52, 8, 113),
            suffix: const Padding(
              padding: EdgeInsets.all(1.0),
              child: Text(
                "руб",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 52, 8, 113)),
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 52, 8, 113)),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 52, 8, 113)),
              borderRadius: BorderRadius.circular(20),
            ),
            fillColor: const Color.fromARGB(255, 52, 8, 113),
            contentPadding: const EdgeInsets.all(15),
          ),
          validator: ((value) {
            if (value!.isEmpty || value == null) {
              return "Обязательное поле";
            } else {
              return null;
            }
          }),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  final String title1;
  final String title2;
  final Color fontColor;
  const Header(
      {Key? key,
      required this.title1,
      required this.title2,
      required this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title1,
          style: TextStyle(
            color: fontColor,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title2,
          style: TextStyle(
            color: fontColor,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class BottonButton extends StatelessWidget {
  final String buttontext;
  final VoidCallback buttonPressed;
  const BottonButton(
      {Key? key, required this.buttontext, required this.buttonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 350,
      child: ElevatedButton(
        child: Text(
          buttontext,
          style: TextStyle(),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 52, 8, 113)))),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(255, 52, 8, 113)),
        ),
        onPressed: () => buttonPressed(),
      ),
    );
  }
}

enum PaymentType { differential, annuity }

class PaymentTypeButton extends StatefulWidget {
  const PaymentTypeButton({Key? key}) : super(key: key);

  @override
  State<PaymentTypeButton> createState() => _PaymentTypeButtonState();
}

class _PaymentTypeButtonState extends State<PaymentTypeButton> {
  PaymentType? paymenttype = PaymentType.differential;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Аннуитетный'),
          leading: Radio<PaymentType>(
            fillColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 52, 8, 113)),
            value: PaymentType.annuity,
            groupValue: paymenttype,
            onChanged: (PaymentType? value) {
              setState(() {
                paymenttype = value;
                paytypeIsDiff = false;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Дифферинцированный'),
          leading: Radio<PaymentType>(
            fillColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 52, 8, 113)),
            value: PaymentType.differential,
            groupValue: paymenttype,
            onChanged: (PaymentType? value) {
              setState(() {
                paymenttype = value;
                paytypeIsDiff = true;
              });
            },
          ),
        )
      ],
    );
  }
}
