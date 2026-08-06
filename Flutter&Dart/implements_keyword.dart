/*
Implemplets Keyword: The `implements` keyword in Dart is used to define a class that implements an interface. An interface is a contract that specifies a set of methods and properties that a class must implement. When a class implements an interface, 
-it agrees to provide concrete implementations for all the methods and properties defined in that interface.
-you can use implements and extends together in a class declaration. This allows a class to inherit from a superclass and also implement one or more interfaces.

*/

void main() { 

}

class Vehicle{
  int speed = 10;
  bool isEngineWorking = false;
  bool isLightsOn = true;
  
  void accelerate(){
    speed += 10;
    print('Vehicle is accelerating. Current speed: $speed');
  }
}

class Car extends Vehicle{
  int noOfWheels = 4;

  void startEngine(){
    print('Car engine started.');
  }
  
}

class Truck extends Vehicle{
  int noOfWheels = 6;

  void startEngine(){
    print('Truck engine started.');
  }
}

class Bike extends Vehicle{
  int noOfWheels = 2;

}

