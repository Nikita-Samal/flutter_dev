/*
-------------Object-Oriented Programming in Dart-------------
-Object-oriented programming (OOP) is a programming paradigm that organizes code into objects, which are instances of classes.
-Classes are blueprints for creating objects, and they encapsulate data (attributes) and behavior (methods) related to that data.
-In Dart, you can define classes using the `class` keyword, and you can create objects (instances) of those classes using the `new` keyword or by simply calling the class constructor.

-1.Polymorphism: Polymorphism allows objects of different classes to be treated as objects of a common superclass.
-2.Encapsulation: Encapsulation is the practice of bundling data (attributes) and methods (functions) that operate on that data within a single unit, i.e., a class. 
                  -It helps in hiding the internal implementation details and provides a public interface for interacting with the object.
-3. Inheritance: Inheritance allows a class to inherit properties and methods from another class, promoting code reuse and establishing a hierarchical relationship between classes.
-4. Abstraction: Abstraction is the process of simplifying complex systems by breaking them down into smaller, more manageable components. 
                  In OOP, abstraction is achieved through abstract classes and interfaces,which define a common interface for a group of related classes without specifying their implementation details.
*/

void main(){
  final date = DateTime.now();
  print('$date');

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