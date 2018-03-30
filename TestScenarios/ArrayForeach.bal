import ballerina/io;
import ballerina/math;


int[] a = [];
int[] i = [];
int[] j = [];
int[] k = [];

function main(string[] args) {
	int elements = 100;
	while (true) {
		test(elements);	
		a = [];
		i = [];
		j = [];
		k = [];
	}	
}

function test(int elements){
	int x = 0;
	while (x < elements ){
		a[x] = math:randomInRange(0,2147483647);
		x = x + 1;
	}	
	
	int y = 0;
	foreach v in a {
		if (v >  100000000){
			i[y] = v;	
		}
		else if (v < 100000) { 
			j[y] = v;	
		}
		else{
			k[y] = v;	
		}
		y = y +1;
	}
}
