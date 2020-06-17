//const userRoutes = require("./users");

const constructorMethod = app => {
  //app.use("/users", userRoutes);
 let data = null;
  app.use("/chat", (req, res) => {
    res.status(200).send('<h1>Hello World</h1>');
  });
  app.post("/map", (req, res)=>{
    data = req.body;
    
  });
  app.get("/mapdata",(req,res)=>{
    res.json(data);
    
  });
};

module.exports = constructorMethod;