/* ------------ Inheritance in Dart ------------
- Inheritance is a fundamental concept in object-oriented programming that allows a class to inherit properties and methods from another class. 
-In Dart, inheritance is achieved using the `extends` keyword.
-is-a relationship: Inheritance represents an "is-a" relationship between classes. For example, 
-if you have a class `Car` that extends a class `Vehicle`, it means that a `Car` is a type of `Vehicle`. 
-The `Car` class inherits the properties and methods of the `Vehicle` class, allowing it to reuse and extend the functionality defined in the parent class.
-multiple inheritance: Dart does not support multiple inheritance, meaning a class can only inherit from one superclass. 
-However, Dart provides a mechanism called mixins that allows you to achieve similar functionality by combining behaviors from multiple classes.
*/

void main(){
  Car car = Car();
  print(car.isEngineWorking); // Output: false
  car.startEngine(); // Output: Car engine started.
  car.accelerate(); // Output: Vehicle is accelerating. Current speed: 20
  print(car.speed); // Output: 20

  Truck truck = Truck();
  print(truck.isLightsOn); // Output: true
  truck.startEngine(); // Output: Truck engine started.
  truck.accelerate(); // Output: Vehicle is accelerating. Current speed: 20
  print(truck.speed); // Output: 20
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