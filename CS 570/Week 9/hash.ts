const size = 21;
const c1 = 11;
const c2 = 2;

class HashTable {
    arr = new Array(21);
    temp = new Array(2);
    size = new Array(21);
    key2value = new Array(100);
    hashed = new Array(21);
    init(){
    	for (var i = 0;i < 21;i++) {
        	this.arr[i] = this.temp;
        	this.size[i] = 0;
    	}
    }
    
	hash(key){
        return key % 21;
    }

    get(key) {
        return this.key2value[key];
    }

    set(key,value) {
        var position = this.hash(key);
        var i = 0;
        while (this.size[position]==2) {
            i += 1;
            position = (position+c1*i+c2*i*i) % 21;
        }
        this.arr[position][this.size[position]] = key;
        this.size[position] += 1;
        this.key2value[key] = value;
        this.hashed[key] = position;
    }

    delete(key){
    	if (this.hashed[key] == undefined) {
    		return false
    	}
    	else {
    		for (var i=0;i<=1;i++){
    			if (this.arr[this.hashed[key]][i]==key){
    				this.arr[this.hashed[key]][i] = undefined;
    				if ((i==0)&&(this.size[this.hashed[key]]==2)) {
    					this.arr[this.hashed[key]][0] = this.arr[this.hashed[key]][1];
    				}
    				this.size[this.hashed[key]] -= 1;
    				return true;
    			}
    		}
    		
    	}
    }

    print(){
    	for (var i=0;i<21;i++){
    		var str = "";
    		str += "(Bucket) ";
    		str += i.toString();
    		if (this.size[i]>=1){
    			str += " (First Key) ";
    			str += this.arr[i][0].toString();
    			str += " (First Value) ";
    			str += this.key2value[this.arr[i][0]];
    		}
    		if (this.size[i]>=2){
    			str += " (Second Key) ";
    			str += this.arr[i][1].toString();
    			str += " (Second Value) ";
    			str += this.key2value[this.arr[i][1]];
    		}
    		console.log(str);
    	}
    }
}

var a = new HashTable();
a.init()
var data = [7, 22, 29, 18, 44, 43, 33, 42, 27, 89, 30, 95, 64, 85];
for (var i=1;i<=data.length;i++){
    a.set(data[i-1],i);
}
a.print();
console.log(a.get(7));
console.log(a.get(22));