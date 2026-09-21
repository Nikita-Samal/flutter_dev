//Loops and Control Statements
//  Loops are used to repeat a block of code multiple times
// Three main types: for, while, do-while
// Control statements: break, continue

void main(){
  // 1. for loop - When you know the number of iterationsd
  // basic for loop
  // syntax: for(initialization; condition; increment/decrement)
  for (int i = 0; i < 5; i++) {
    // i = 0: initialization (runs once)
    // i < 5: condition (checked before each iteration)
    // i++: increment (runs after each iteration)
    // i++ == i= i+1
    //i-- = i = i-1
    //i+=2 == i = i+2
    print("Iteration ${i+1}"); // Prints 0,1,2,3,4
  }
  // hen i becomes 5, condition (5 < 5) is false, loop stops
  print('----------------------------------------------------');
  // For loop with step (increment by 2)
  for (int i = 0; i < 10; i += 2) {
    print("Even number: $i"); // Prints 0,2,4,6,8
  }
   print('----------------------------------------------------');


  for(int i = 0; i<10;i++){
    String hi = 'Hello World';
    print(hi.substring(1,10)); // substring method to get a part of the string.
    print('Hello World ${i+1}');
  }
    print('--------------------for in loop--------------------------------');


  // for in loop - used to iterate over collections (like lists, sets, maps)
  String value = 'example';

  for(int i=0; i<value.length; i++){
    print(value[i]);
  }

   //  while loop - when condition-based may run 0 times
  // while loop
  print("------------ While loop ---");
  int count = 0;
  while (count < 5) {
    // Checks condition 1st
    // if false, loop never runs
    print("Count: $count");
    count++; //  increment to avoid infinite loop
  }

    // While with break (exit loop)
  print("\n--- While with Break ---");
  int num = 1;
  while (num <= 10) {
    if (num == 6) {
      print("Reached $num, breaking");
      break; // Exits loop immediately
    }
    print("Number: $num");
    num++;
  }
  
  // While with continue (skip iteration)
  print("\n--- While with Continue ---");
  int i = 0;
  while (i < 5) {
    i++;
    if (i == 3) {
      print("Skipping $i");
      continue; // Skips rest of this iteration
    }
    print("Value: $i");
  }

//do-while loop : Runs at least once
print("------------ Do-While loop ---");
  int x = 0;
  do {
    // Runs 1st, then checks condition
    print("x: $x");
    x++;
  } while (x < 5);
  
  // Do-while with false condition runs once.
  int y = 10;
  do {
    print("This runs once even though condition is false");
    print("y = $y");
    y++;
  } while (y < 5); // Condition is false (10 < 5)
  // Still runs once important difference from while
}

/*
   for -Known number of iterations          
   for-in  - Iterating over collections                       
   while  ---   Unknown iterations, may not run     
   do-while  - Must run at least once              
      
*/