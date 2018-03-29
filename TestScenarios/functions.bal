import ballerina/io;

@Description {value:"Add function"}
function add (int a, int b) returns (int) {
    int c = multiplyA(a);
    int d = multiplyB(b);
    return c + d;
}

@Description {value:"Multiply function"}
function multiplyA (int a) returns (int) {
    int result = subA(a*10);
    return result;
}

@Description {value:"Substract function"}
function subA (int a) returns (int) {
    int result = AddA(a);
    return result - 5;
}

@Description {value:"Add function"}
function AddA (int a) returns (int) {
    int result = PowerA(a);
    return result + 15;
}

@Description {value:"Power Function"}
function PowerA (int a) returns (int) {
    int result = divideA(a);
    return result * result;
}

@Description {value:"Divide function"}
function divideA (int a) returns (int) {
    return a / 10;
}

@Description {value:"Multiply Function"}
function multiplyB (int b) returns (int) {
    int result = PowerB(b);
    return result * 5;
}

@Description {value:"Power Function"}
function PowerB (int b) returns (int) {
    return b * b * b * b;
}


function main (string[] args) {
    int i = 0;
    while (i < 7200000000) {
	    int result = add(5, 6);
	    i = i +1;
    }
}
