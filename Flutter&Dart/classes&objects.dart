/* 
Classes:
--------------
Classes are the blueprint for creating objects. They encapsulate data for the object and methods to manipulate that data. 
In Dart, classes are defined using the 'class' keyword, 
followed by the class name and a pair of curly braces containing the class members (fields, constructors, methods, etc.).

example:
class Person {
  String name;
  int age;  
}

- Class we use PascelCase unless like function & variable we use camelCase.


------------------Objects-------------------
Objects are instances of classes. When a class is defined, no memory is allocated until an object of that class is created. 
Objects are created using the 'new' keyword followed by the class name and parentheses. However, in Dart, the 'new' keyword is optional.
example:
Cookie cookie = Cookie();
var person = Person();  
final cookkie = Cookie(); 

*/

void main(){
  Cookie();
  print(Cookie());
  print(Cookie().shape);
  print('${Cookie().size} cm');
  Cookie().baking();
  print(Cookie().isCooking());

  final isCookieCooling = Cookie().isCooking();
  print(isCookieCooling);
  // we can create a instance or object and can call anything
  print('-------------------after creating obj -----------');
  Cookie cookie = Cookie();
  print(cookie.shape);
  print('${cookie.size} cm');
  print(cookie.isCooking());
  cookie.baking();

  final cookkie = Cookie(); //obj creation
  cookkie.shape = 'Rectangle';
  print(cookkie.shape);
  cookkie.size = 18.5;
  print(cookkie.size);
  
  
}

class Cookie{// curly braces define the scope of the class
  //variable
  String shape = 'circle';
  double size = 15.2; //in cms

  //function or method more precisely
  void baking(){
    print('Baking has Started.');
  }

  bool isCooking(){
    return false;
  }

}