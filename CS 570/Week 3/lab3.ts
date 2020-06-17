
const readline=require('readline');
const r1=readline.createInterface(process.stdin,process.stdout);
r1.question('what is the number of the sequence?',answer=>{
	FizzBuzzer(answer);
});

function FizzBuzzer(n){
	if((Number.isInteger(n)) || (n<1)){
	throw "n is not a positive integer.";
	}
	let arr=[];
	for(let i=0;i<n;i++){
	arr[i]=Math.floor(Math.random()*240)+10
	}
	console.log("the random array is",arr);
	arr.sort(function(a,b){
	return a-b;
	});
	console.log("the sequential array is",arr);
	let manipulatedArr=[];
	manipulatedArr=arr;
	for(let i=0;i<n;i++){
		if(manipulatedArr[i]%3===0&&manipulatedArr[i]%5!==0){
			manipulatedArr[i]="Buzz";
		}
		else if(manipulatedArr[i]%3!==0&&manipulatedArr[i]%5===0){
			manipulatedArr[i]="Fizz";
		}
		else if(manipulatedArr[i]%3===0&&manipulatedArr[i]%5===0){
			manipulatedArr[i]="FizzBuzz";
		}
	}
	console.log("the manipulated array is",manipulatedArr);
}