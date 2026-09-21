/*
------------Variables---------------
syntax
--------
<datatype> <variable name> = value;

example
---------
int a = 6;
String c = "Nikita";
float b = 5.6;
*/

/*
Data Types
int = whole number ---- 1,2,4,-7.....
float = fraction number  ---- 1.3, 4.5,.....
double
String---- texts --- "niki", "Rivan", "india"
char -- a, b, t,.....
long
bool -- true & false

*/

void main(){
  int firstValue = 302;
  int secondValue =52;
  // dart is case sensitive so the variable name should not be same.


  print(firstValue);
  print(secondValue);
  print(firstValue+secondValue);
  print(firstValue-secondValue);
  print(firstValue*secondValue);
  print(firstValue/secondValue);

  // if we use variable we dont need change each print statement value we only need to change the variable value at firstValue and SecondValue.
  print(19);

  bool ischild = true;

  print(ischild);

  dynamic isadult = 10.6;  // when we use dynamic it can take any value
  // but it is not recommended to use dynamic . at compile time the dt is unknown , at runtime it will be known..
   print(isadult);

  //reassigning value
   firstValue -= 350;
    print(firstValue);


  //String
  String greeting = 'Hello, World';
  print(greeting);

  //greeting = greeting + ' Yooo'; // this + operator generally not use in string 

  greeting ='$greeting Yooo';
  // when you want to use $ for currency you can put a \ so that it will lose it's speacial importance. like \$12
print(greeting);
  String info = ''' sun
  set
  on 
  west '''; // for multi line String and also use \n for next line.
  print(info);



//-----var/final/const variableName = value;

var someValue1 = '10'; // the value can vary --- mutable
final someValue2 = '10';//final variable can only set once ---immutable
const someValue3 = '10';//constant variable canot assign a value.----immutable


print(someValue1);
print(someValue2);
print(someValue3);

print("---------");
someValue1 = '101'; 
//someValue2 = '101'; 
// someValue3 = '101'; 

final a = DateTime.now(); //runtime const
// const b = DateTime.now(); // compile time const
print(a);


/* Optional Variable

//String/bool/int and null

// String aValue = '';
// String? bValue = null;
 // ' ' has a value of String , it doesnot mean aValue has no value.
 //but when u use null it has no value

 --------------------------
  local variable = variable declared inside the function.
  global variable = variable declared outside the function.
*/

}