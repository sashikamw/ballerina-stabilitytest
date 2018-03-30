import ballerina/io;
import ballerina/runtime;
import ballerina/mime;

int count;

function main(string[] args) {
  while (true) {
  // call the function "sum" asynchronously
  future<int> f1 = async sum(40, 50);
  // future values can be passed around to get the result later
  int result = square_plus_cube(f1);

  // call "countInfinity", which will run forever in async mode
  future f2 = async countInfinity();
  runtime:sleepCurrentWorker(1000);
  boolean cancelled = f2.cancel();
}
}

function sum(int a, int b) returns int {
  return a + b;
}

function square(int n) returns int {
  return n * n;
}

function cube(int n) returns int {
  return n * n * n;
}

function power(int n) returns int {
  return n * n * n * n;
}

function fifthpower(int n) returns int {
  return n * n * n * n * n;
}

function sixthpower(int n) returns int {
  return n * n * n * n * n * n;
}

function square_plus_cube(future<int> f) returns int {
  worker w1 {
    int n = await f;
    int sq = square(n);
    sq -> w2;
  }
  worker w2 {
    int n = await f;
    int cb = cube(n);
    int sq;
    int value;
    sq <- w1;
    value = sq + cb;
    value -> w3;
  }

  worker w3 {
    int n = await f;
    int pw = power(n);
    int value;
    int value2;
    value <- w2;
    value2 = value + pw;
    value2 -> w4;
  }

  worker w4 {
    int n = await f;
    int fpw = fifthpower(n);
    int value2;
    int value3;
    value2 <- w3;
    value3 = value2 + fpw;
    value3 -> w5;
  }

  worker w5 {
    int n = await f;
    int spw = sixthpower(n);
    int value3;
    value3 <- w4;
    return value3 + spw;
  }
}

function countInfinity() {
  while (true) {
    count++;
  }
}
