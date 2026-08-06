/*
---------------Polymorphism----------------
-Polymorphism is a fundamental concept in object-oriented programming (OOP) that allows objects of different classes to be treated as objects of a common superclass. 
-It enables a single interface to represent different types of objects, allowing for flexibility and extensibility in code design.
-Polymorphism can be achieved through method overriding and interfaces. In Dart, polymorphism is primarily implemented using inheritance and method overriding.
-There are two types of polymorphism:
1. Compile-time polymorphism (Static polymorphism): This type of polymorphism is resolved during compile time. It is achieved through method overloading, where multiple methods with the same name but different parameter lists exist in the same class. 
            -----Dart does not support method overloading directly, but you can achieve similar behavior using optional parameters or named parameters.


2. Runtime polymorphism (Dynamic polymorphism): This type of polymorphism is resolved during runtime. It is achieved through method overriding, where a subclass provides its own implementation of a method that is already defined in its superclass. 
             ---------This allows the program to determine the appropriate method to call based on the actual object type at runtime. 

-It allows objects of different classes to be treated as objects of a common superclass, enabling flexibility and extensibility in code design.

*/

void main(){

  Animal cat = Cat();
  cat.sound();
  cat = Dog();
  cat.sound();
}


class Animal{
  void sound(){
    print('Animal makes a sound');
  }
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