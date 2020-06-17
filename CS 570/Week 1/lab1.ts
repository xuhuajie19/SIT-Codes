var MIN = 74;
var MAX = 291;
for (var i = MIN;i <= MAX;i++){
	var word = ""
	if (i % 3===0){
		word += "Buzz"
	}
	if (i % 5===0){
		word += "Fizz"
	}
	if (word !== "")
		console.log(word);
	else
		console.log(i)
}