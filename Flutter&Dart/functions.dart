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

*/

void main(){
  printName();// calling of the fuction printName.
  print(getNumber());
  print(getString());

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




/*

void = returns nothing
return = gives back value
[ ] = optional parameter
=> = one line function shortcut
*/