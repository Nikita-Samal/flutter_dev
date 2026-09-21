/*---------------Mixin----------------
-Mixin is a way to reuse code in multiple classes in Dart.
-It allows you to add functionality to a class without using inheritance.
-A mixin is a class that provides methods and fields that can be used by other classes.
-You can use the 'with' keyword to apply a mixin to a class.
-Mixins are useful when you want to share code between unrelated classes.
*/


void main(){


}
mixin Jump{
  int jumping = 10;

}

class Animal with Jump{
  // print(Jumping);
}