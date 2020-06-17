interface Vector<T> extends Iterable<T> {
	get(index: number);
 	set(index: number, value: T);
 	length: number;
 	push(value: T);
 	pop();
 	insert(index: number, value: T);
 // remember to implement the iterable functionality
 	[Symbol.iterator]();

}

class FakeVector<T> implements Vector<T> {
	arr: T[];
	length: number=0;

	get(index:number){
		if(index<=0){
			throw 'index is not a positive number';
		}
		else if(index>this.length){
			throw 'index is grater than the length of the array';
		}
		else{
			console.log("the ",index," number is ",this.arr[index-1]);
		}
	}

	set(index:number,value:T){
		if(index<=0){
			throw 'index is not a positive number';
		}
		else if(index>this.length){
			throw 'index is grater than the length of the array';
		}
		else{
			this.arr[index-1]=value;
		}
	}

	push(value:T){
		if (!this.arr){
			this.arr = [];
		}
		this.arr[this.length]=value;
		this.length++;
	}

	pop(){
		console.log("oldarr:",this.arr);
		if(this.length===0){
			throw 'the array has already empty';
		}
		else{
			this.length--;
			this.arr.pop();
		}
	}

	insert(index:number,value: T){
		if(index<=0){
			throw 'index is not a positive number';
		}
		else if(index>this.length){
			throw 'index is grater than the length of the array';
		}
		else{
			for(let i=this.length;i>=index;i--){
				this.arr[i]=this.arr[i-1];
			}
			this.arr[index-1]=value;
			this.length++;
		}
	}

	*[Symbol.iterator](){
		for(let i=0;i<this.length;i++){
			yield this.arr[i];
		}
	}
}

 function output_list(list: Iterable<any>) {
 	// output each item in the list
 	for (let item of list)
 		console.log(item);
 }

let fvec = new FakeVector<number>();

console.log("Push the numbers\n");
fvec.push(67);
output_list(fvec);
fvec.push(96);
output_list(fvec);
fvec.push(753);
output_list(fvec);

console.log("get the number\n");
fvec.get(2);
output_list(fvec);

console.log("set the number\n");
fvec.set(2,55);
output_list(fvec);

console.log("\nPop\n");
fvec.pop();
output_list(fvec);

console.log("insert the number\n");
fvec.insert(2,78);
output_list(fvec);

console.log("\nPop\n");
fvec.pop();
output_list(fvec);
console.log("\nPop\n");
fvec.pop();
output_list(fvec);
console.log("\nPop\n");
fvec.pop();
output_list(fvec);
