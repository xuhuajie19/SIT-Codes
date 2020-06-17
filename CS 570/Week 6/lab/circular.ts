const readlines = require('readline-sync');

const MAXSIZE = 12;
type LNode<T> = {value: T, next: LNode<T>};
type Iterated<T> = {value: T, insertAfter: (value: T) => void}

class LinkedList<T>{
	head: LNode<T>;

	length(): any{
		let p = this.head;
		var temp = 0;
		for (;p != null;p = p.next){
		    temp++;
		}
		return temp;
	}
	count: number = 0;
	insertAtHead(value: T){
		this.count++;
		if (this.count>MAXSIZE){
			let p = this.head;
			for (var i=0;i<MAXSIZE-this.count % MAXSIZE;i++){
				p = p.next;
			}
			p.value = value;
		}
		else{
			this.head = {value, next: this.head};
		}
	}
	print(): any{
		var a = new Array();
		// FIFO
		for (let x = list.head; x != undefined; x = x.next) {
			a.push(x.value);
		}
		a = a.reverse();
		for (var i=0;i<a.length;i++){
			console.log(a[i]);
		}
	}
}

const list = new LinkedList<number>();
while (true){
	let cmd = readlines.question("Please insert the string you want to add to the Circular queue: ");
	if (cmd=="quit"){
		list.print();
		process.exit(0);
	}
	else{
		list.insertAtHead(cmd);
		console.log("Element added.")
	}
}