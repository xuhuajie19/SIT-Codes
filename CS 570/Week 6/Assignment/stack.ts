class Stack<T> {
	private arr: T[];

	constructor(arr?: T[]){
		this.arr = arr || [];
	}

	public push(value: T) {
		this.arr.push(value);
	}

	public pop(): T {
		return this.arr.pop();
	}

	public peek(): T {
		return this.arr[this.arr.length-1];
	}

	public get length(){
		return this.arr.length;
	}
	public clear() {
		this.arr = [];
	}
}

/* Stack Example */
function outputToScreen<T>(stack: Stack<T>) {
	let value: T;
	while (value = stack.pop()){
		console.log(value);
	}
}

function decimalToBinary(num: number): string {
	let remainderStack = new Stack<string>();
	while (num > 0){
		let remainder = Math.floor(num % 2);
		remainderStack.push("" + remainder);
		num = Math.floor(num / 2);
	}

	let binary = "";
	let value: string;
	while (value = remainderStack.pop()) {
		binary += value;
	}
	return binary;
}

console.log(decimalToBinary(4));