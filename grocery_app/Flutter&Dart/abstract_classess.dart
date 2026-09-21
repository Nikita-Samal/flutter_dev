/*
-------------Abstract Classes in Dart-------------
-Abstract classes in Dart are classes that cannot be instantiated directly. They are designed to be subclassed by other classes. 
-It can have both abstract methods (methods without implementation) and concrete methods (methods with implementation).
-These classes are useful when you want to define a common interface or behavior that multiple subclasses should adhere to, while allowing each subclass to provide its own implementation for the abstract methods.
-Abstract classes are declared using the `abstract` keyword before the class name.
-If you extend / implements the abstarcat class, you must provide override for all the abstract methods in the abstract class.
-Classes are implecitly abstract, but abstract classes can not be constructed. If you try to create an instance of an abstract class, you will get a compile-time error.
-
*/

void main(){
  final Car car = Car();
  car.accelerate();

}

abstract class Vehicle{
  void accelerate();
  int noOfWheels = 4;
}

class Car implements Vehicle{
  @override
  void accelerate() {
    print('Car is accelerating.');
  }
  @override
  int noOfWheels = 4;
}

