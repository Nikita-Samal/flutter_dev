/*
  - Private variables are those that can only be accessed within the class they are defined in. 
  - In Dart, private variables are denoted by a leading underscore (_). 
  - This means that if you define a variable with an underscore, it cannot be accessed from outside the class.
  - For example, in the Cookie class, the _shape and _size variables are private and cannot be accessed directly from outside the class.
  - To access these private variables, you can create public getter and setter methods within the class.
*/

void main(){
  final cookie = Cookie(shape: 'circle', size: 15.2);
  // print(cookie._height); // Accessing private variable within the class is allowed
  // print(cookie._height); // This will cause an error if uncommented, as _height is private and cannot be accessed from outside the class.
}

class Cookie{
  final String shape ;
  final double size;

  Cookie({required this.shape, required this.size}){
    baking();
  }

  //private variables
  int _height =4;
  int _width =5;

  int calculateSize(){
    return _height * _width; 
  }
  
  void baking(){
    print('Baking has Started.');
  }
}