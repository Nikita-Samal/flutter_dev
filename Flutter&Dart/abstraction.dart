/*
---------------Abstraction----------------
-Abstraction is a fundamental concept in object-oriented programming (OOP) that focuses on simplifying complex systems by breaking them down into smaller, more manageable components.
-It allows you to define the essential characteristics of an object while hiding unnecessary implementation details.
-In Dart, abstraction is achieved through abstract classes and interfaces.
-It used hides the complexity of the system and provides a simplified view to the user. It allows you to focus on what an object does rather than how it does it.
-Abstract classes can not be instantiated directly, but they can be subclassed by other classes. They can contain both abstract methods (methods without implementation) and concrete methods (methods with implementation).
-

*/

void main(){

  Animal anim = Cat();
  anim.sound();
  Animal anim2 = Dog();
  anim2.sound();
  
}


abstract class Animal{
  void sound();
}

class Cat extends Animal{
  @override
  void sound(){
    print('Cat making sound');
  }
}

class Dog extends Animal{
  @override
  void sound(){
    print('Dog making sound');
  }
}