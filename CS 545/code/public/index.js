const express = require("express");
const bodyParser = require("body-parser");
//
const exphbs = require("express-handlebars")
//
const configRoutes = require("./routes");
const app = express();
var http = require('http').Server(app);
const io = require("socket.io")(http);
app.use(express.static('public'));

app.use(express.json({ limit: '10mb' }));
//
app.engine('handlebars', exphbs({
    defaultLayout: 'main',
    extname: 'handlebars'
}));
app.set('view engine', 'handlebars');
//
app.get('/chat2', function(req, res){
  res.sendFile(__dirname + '/public/index.html');
});

app.get('/2', function(req, res){
  res.sendFile(__dirname + '/public/chat_room2.html');
});

io.on('connection', function(socket){
  console.log('a user connected');
  socket.on('disconnect', function(){
    console.log('user disconnected');
  });
});
io.on('connection', function(socket){
  socket.on('chat message', function(msg){
    console.log('message: ' + msg);
  });
});

io.emit('some event', { for: 'everyone' });

io.on('connection', function(socket){
  socket.broadcast.emit('hi');
});

io.on('connection', function(socket){
  socket.on('chat message', function(msg){
    io.emit('chat message', msg);
  });
});

io.on('connection', function(socket){
   socket.on('point', function(data){
     console.log('messa' + data);
     io.emit('point', data);
   });
});

configRoutes(app);

http.listen(3000, () => {
  console.log("We've now got a server!");
  console.log("Your routes will be running on http://localhost:3000");
});
