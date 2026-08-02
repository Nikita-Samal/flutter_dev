/*
____________Getter and Setters _____________
-#---getter and setter are special methods that allow you to access and modify the properties of an object.
# --it uses the get and set keywords to define these methods.
#-- it used to return the value of a private variable and set the value of a private variable.
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


  //getter
  int get height => _height; 
   



  int calculateSize(){
    return _height * _width; 
  }




  void baking(){
    print('Baking has Started.');
  }

 


}