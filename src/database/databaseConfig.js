var mysql = require('mysql2');
const mysqlConnection=mysql.createPool({
    host:'localhost',
    port:'3306',
    user:'root',
    //password:'19847173Alvaro',
    database:'universidad',
    waitForConnections: true,
    connectionLimit: 100,
    queueLimit: 0
})

// mysqlConnection.getConnection(function (err){
//     if(err){
//         return err
//     }else{
//         console.log("database connected")
//     }
// })
module.exports= mysqlConnection