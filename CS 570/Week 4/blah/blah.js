class Vector {
    constructor(capacity = 0) {
        this.length = 0;
        this.arr = new Array(capacity);
    }
    get capacity() { return this.arr.length; }
    resize(length) {
        // two cases: length <= capacity, or length > capacity
        if (length > this.capacity)
            this.reserve(length);
        this.length = length;
    }
    reserve(capacity) {
        if (this.capacity >= capacity)
            return;
        const copy = new Array(capacity * 2);
        for (let i = 0; i < this.length; i++)
            copy[i] = this.arr[i];
        delete this.arr; // optional
        this.arr = copy;
    }
    get(index) {
        if (index < 0)
            throw new Error("index must be positive");
        if (index >= this.length)
            return undefined;
        return this.arr[index];
    }
    set(index, value) {
        if (index < 0)
            throw new Error("index must be positive");
        if (index >= this.length)
            throw new Error("index exceeds length");
        this.arr[index] = value;
    }
    *[Symbol.iterator]() {
        for (let i = 0; i < this.length; i++)
            yield this.arr[i];
    }
}
function output_list(list) {
    // output each item in the list
    for (let elem of list)
        console.log(elem);
}
const vec = new Vector();
console.log(12);
vec.resize(5);
output_list(vec);
vec.set(0, 10);
output_list(vec);
vec.set(1, 20);
output_list(vec);
