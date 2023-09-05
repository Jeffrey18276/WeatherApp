

import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async{
  task1();
  String task2Result=await task2();
  task3(task2Result);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future <String> task2() async  {//Future is a promise for the future ,kind of a receipt we wait for a coffee
  String result='';
  Duration delay=Duration(seconds: 3);
   await Future.delayed(delay,(){
    result = 'task 2 data';
    print('Task 2 complete');
  });//instead of sleep(synchronous)
  return result;

}

void task3(String task2Data) {
  String result = 'task 3 data';
  print('Task 3 complete $task2Data');
}