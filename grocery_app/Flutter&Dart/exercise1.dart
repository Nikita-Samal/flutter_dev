/*
Exercise:
Develop a program to calculate the shiping cost based on the zone and
the weight of the package(you will be provided)
calculate the shipping cost according to these conditions:
1.If the destination zone is 'xyz', the shipping cost is $5 per kilogram.
2.If the destination zone is 'ABC', the shipping cost is $7 per kilogram.
3.If the destination zone is 'PQR', the shipping cost is $10 per kilogram.
4.If the destination zone is not 'XYZ','ABC','PQR', display an error message.

*/

void main(){
  String destinationZone = 'ABC';
  double weightInKgs = 6.0;

  //using if else
  // if (destinationZone =='XYZ'){
  //   print('Shipping cost:${weightInKgs*5}');
  // } else if (destinationZone =='ABC'){
  //   print('Shipping cost:${weightInKgs*7}' );
  // } else if (destinationZone =='PQR'){
  //   print('Shipping cost:${weightInKgs*10}');
  // } else {
  //   print('Error: Invalid destination zone' );
  // }


  double cost =0;
  if (destinationZone =='XYZ'){
    cost = weightInKgs * 5;
  } else if (destinationZone =='ABC'){
    cost = weightInKgs * 7;
  } else if (destinationZone =='PQR'){
    cost = weightInKgs * 10;
  } else {
    print('Error: Invalid destination zone' );
    return;
  }

  print('Billing Cost: $cost');


  //using switch case
  // switch(destinationZone){
  //   case 'XYZ':
  //     print('Shipping cost:${weightInKgs*5}');
  //     break;
  //   case 'ABC':
  //     print('Shipping cost:${weightInKgs*7}');
  //     break;
  //   case 'PQR':
  //     print('Shipping cost:${weightInKgs*10}');
  //     break;
  //   default:
  //     print('Error: Invalid destination zone');
  // }

}

