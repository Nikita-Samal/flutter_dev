//control flow statements

//Operators
/*
== is a relational operator that checks if two values are equal.
= is an assignment operator that assigns a value to a variable.
! in != stands for not equal to, it checks if two values are not equal. == is equal to and != is not equal to.
{} -- scope
*/

void main(){

//if statement
  int age = 29;

  bool isadult =false;

  // if(age >= 18){
  //   print("You are eligible to vote");
  // }
  // else if(age < 18 && age >= 16){
  //   print("You are not eligible to vote but you can apply for voter id");
  // }
  // else{
  //   print("You are not eligible to vote");
  // } 

  if(age >= 18 && !isadult){
    print("You are eligible to vote");
    
  }
  else{
    print("You are not eligible to vote");

  }

  //ternary
    String somevalue ='hi!!';

    String value = somevalue.startsWith('h')? 'wow' : 'nope';
    print(value);

  //switch case

  switch(somevalue){
    case 'hi':
      print('Hello'); // break is used only when this line is empty otherwise after dart 3 there is no use of break statement in dart.
    case 'hi!':
      print('Hello!');
    
    case 'hi!!' when age>=20:
      print('yep!!!!!!');
    case'hi!!!':
      break;
    default:
      print('No match found');
    //switch didnot allow using relational operatos (like ==, !=) until dart3. 
    
  }


}