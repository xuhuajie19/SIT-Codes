class Stack<T> {
	private arr: T[];

	constructor(arr?: T[]){
		this.arr = arr || [];
	}

	public Push(value: T) {
		this.arr.push(value);
	}

	public Pop(): T {
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

class Queue<T> {
	private arr: T[];

	constructor(arr?: T[]) {
		this.arr = arr || [];
	}

	public EnQueue(value: T) {
		this.arr.push(value);
	}

	public DeQueue(): T {
		return this.arr.shift();
	}

	public peek(): T {
		return this.arr[0];
	}

	public get length() {
		return this.arr.length;
	}
	public clear() {
		this.arr = [];
	}
}

var eva = new Stack<number>();
var postQ = new Queue<string>();
// postQ contains the postfix expression to be evaluated.
var t:string;
var topNum, nextNum, answer:number;

while (postQ.length>0){
	var p = postQ.Front();
	postQ.DeQueue();
	if (t){
		eva.Push(parseInt(t));
	}
	else {
		topNum = eva.Top();
		eva.Pop();
		nextNum = eva.Top();
		eva.Pop();
	}
	switch (t) {
		case '+': {
			answer = nextNum + topNum;
			break;
		}
		case '-': {
			answer = nextNum - topNum;
			break;
		}
		case '*': {
			answer = nextNum * topNum;
			break;
		}
		case '/': {
			answer = nextNum / topNum;
			break;
		}
	}
	eva.Push(answer);
}
return eva.Top();


var opStack = new Stack<string>();
var infixQ = new Queue<string>();
// infixQ contains the infix expression tobe converted.
// postQ contains the converted postfix expression.
var t:string;
while (infixQ is not empty){
	t = infixQ.Front();
	infixQ.DeQueue();
	if (t is a number token)
		postQ.EnQueue(t);
	else if (opStack.IsEmpty())
		opStack.Push(t);
	else if (t is a left paren token)
		opStack.Push(t);
	else if (t is a right paren token) {
		while (opStack.Top() is not a left paren) {
			postQ.EnQueue(opStack.Top());
			opStack.Pop();
		}
		opStack.Pop();
	}
	else {
		while (opStack is not empty and opStack.Top() != '(' and ) {
			postQ.EnQueue(opStack.Top());
			opStack.Pop();
		}
		opStack.Push(t);
	}
}