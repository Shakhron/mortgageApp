import 'dart:math';

class Mortgage_Calculator {
  double sum = 2500000;
  int period = 15;
  double percent = 12.5;
  bool typediff = true;
  double initialPayment = 0;
  var result = Map<String, dynamic>();
  var arr_result;

  Map<String, dynamic> sumResult() {
    result['Initial Payment'] = initialPayment.round();
    result['Sum'] = sum.round();
    result['Period'] = period;
    result['Percent'] = percent;
    result['Type is diff'] = typediff;
    if (typediff) {
      result["Monthly Payment"] = arr_result;
      result["Total"] = arr_result.fold(0, (p, c) => p + c);
    } else {
      result["Monthly Payment"] = arr_result[0];
      result["Total"] = arr_result[1];
    }
    return result;
  }

  List<int> calcul() {
    if (typediff) {
      arr_result = diff_mc();
      return arr_result;
    } else {
      arr_result = ann_mc();
      return arr_result;
    }
  }

  List<int> diff_mc() {
    List<int> arr = [];
    var mpCnt = period * 12;
    var rest = sum - initialPayment;
    var mpReal = (sum - initialPayment) / (period * 12);
    var mp = 0.0;
    while (mpCnt != 0) {
      mp = mpReal + (rest * percent / 1200);
      arr.add(mp.round());
      rest = rest - mpReal;
      mpCnt--;
    }

    return arr;
  }

  List<int> ann_mc() {
    var mpCnt = period * 12;
    var r = percent / 1200.0;
    var ak = (r * pow((1 + r), mpCnt)) / ((pow((1 + r), mpCnt)) - 1);
    var mp = (sum - initialPayment) * ak;
    var total = mp * mpCnt;
    return [mp.round(), total.round()];
  }
}
