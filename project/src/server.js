const express=require('express');
const app=express();
const mysql=require("mysql");
app.post('/', function(req,res){
    const config={
        user:'root',
        password:'',
        server:'localhost',
        database:'evcharging'
    };
    mysql.connect(config, function(err){
        let request=new mysql.Request();
        request.query('select * from user',function(err,records){
            res.send(records);
        });
    });
});
let server = app.listen(3306,function(){
    console.log('Server is listening at port 3306...');
});
