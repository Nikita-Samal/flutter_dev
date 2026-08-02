/*
------------functions---------------
what is function?
- block of code that does a specific task
- like a machine: input → process → output

why need functions?
- reuse code (write once, use many times)
- clean & organized code
- easy to fix/change

syntax
------
returntype functionname(parameters) {
  // code
  return value; // optional
}
 
example
-------
void greet() {
  print("hello");
}

int add(int a, int b) {
  return a + b;
}


*. ------- Anonymous Functions 
---> Functions that don't have nay name but behave like a function (block of code that can be executed) are anonymous functions.
example: (){
print('Hey');
}
will use lot in flutter.

*/

void main(){
  printName();// calling of the fuction printName.
  print(getNumber());
  print(getString());
  var (age, name, isadult, greetings) = printDetails();
  print(age);
  print(name);
  print(isadult);
  print(greetings);

  printPA(name: 'Positional argument - PA', age: 15, greetings: 'hey PA');
  printPAN(greetings: 'hey , null', name: 'positional argument using null PAN',age: 167);
  posNamArg('Positional+named', greetings: 'heyyyy...posnamedargs');

  final (agee, namee) = stuff();
  print(agee);
  print(namee);

  final stufff = namedVal();
  print(stufff.agee);
  print(stufff.namee);

  final greett = anonyFunc();
  print(greett);

  anonyFunc2();

}




void printName(){
  print('Nikita');
}
int getNumber(){
  return 10;
} 

String getString(){
  return 'Hello World';
}

(int, String, bool, String) printDetails(){
  return (12, 'Nikita', false, 'Hello');
}

int? getNum(){
  return null;
}

void printValue(value){
    print(value);
}

void printPA({ required String name, required int age,required String greetings}){ // postional arguments
  print(name);
  print(age);
  print(greetings);
}
//it does not required to be arrange in order
// if you dont want to make any parameter required you can make it null.
void printPAN({ required String name,  int? age,required String greetings}){ // postional arguments
  print(name);
  print(age);
  print(greetings);
}

//postional+named arguments
void posNamArg(String name,{int? age,required String greetings}){ 
  print(name);
  print(age);
  print(greetings);
}

 (int, String) stuff(){
  return(19,'samal');
}

({int agee, String namee}) namedVal(){
  return (agee: 78, namee: 'named value');
}

//Anonymous function

String anonyFunc() => 'heyyyy';// '=>' is used when we have only to retuen one statement

void anonyFunc2() => print('yooo');




/*

void = returns nothing
null = returns null
return = gives back value
[ ] = optional parameter
=> = one line function shortcut

--> we can have constant in function. beacuse const variable must be initialized with a constant value.
  but functions are not const values.-----> we can use final/var.
-----------------------------------
-after return everything is ignored.
-if you are using ? after the return type, it means the function can return null.
  example:
  int? getNum(){
    return null;
  }
=============================
-if you are using ! after the return type, it means the function will never return null.
  example:
  int! getNumb(){
    return 10;
  }
-------------------------------------------------
-if you are not using datatype of parameter, it means the parameter can be of any datatype.
  example:
  void printValue(value){
    print(value);
  }
  it will assume that the value can be of dynamic datatype.

  -------------------
  local variable = variable declared inside the function.
  global variable = variable declared outside the function.

  -----------------------------
  named arguments/ postional arguments
  
*/