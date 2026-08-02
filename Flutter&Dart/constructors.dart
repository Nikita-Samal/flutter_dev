/*
----------Constructors----------
Constructors are special methods that are called when an object is created. They are used to initializethe object's properties. 
In Dart, constructors have the same name as the class and do not have a return type.

Example:
class Person{
  Person(){}
}

----------this keyword----------------------
->by this keyword we can access the class we are in.

*/

void main(){
  final cookkie = Cookie("n",20); 
  print(cookkie.shape);
  print(cookkie.size);

}

class Cookie{// curly braces define the scope of the class

  String shape;
  double size;

  //Constructor
  Cookie(this.shape, this.size){  // because we have not given any value to variable  we used 'this' here . 
  //if we don't use 'this' we have to give some value or we can make them null by putting String?.shape .
    print(this);
    print('Cookie constructor called');
    baking();
  }

  //function or method more precisely
  void baking(){
    print('Baking has Started.');
  }

  bool isCooking(){
    return false;
  }

}