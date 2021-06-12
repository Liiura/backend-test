const mysqlConnection=require('../database/databaseConfig')

class StudentService{
    async InsertStudent(idStudent, name, lastName, age, email, careername){
        try {
            const payload = await this.GetStudenById(idStudent,email)
            if(payload.Data.length === 0){
                return new Promise((resolve,reject)=>{
                    mysqlConnection.getConnection(function(errConn,conn){
                        try {
                            if(!errConn){
                                conn.query('CALL insertStudent(?,?,?,?,?,?)',[idStudent,name,lastName,age,email,careername],(err)=>{
                                    if(!err){
                                        resolve({StatusCode:201,Message:'Sucesss'})
                                    }else{
                                        reject(err)
                                    }
                                })
                            }else{
                                reject(errConn)
                            }
                        } catch (error) {
                        }
                    })
                })
            }else{
                return {Status:409,Message:"The inserted user is in the data base"};
            }
        } catch (error) {
            return error
        }

    }
    UpdateStudent(idStudent,name,lastName,age,email){
        return new Promise((resolve,reject)=>{
            mysqlConnection.getConnection(function(errConn,conn){
                try {
                    if(!errConn){
                        conn.query('CALL updateStudent(?,?,?,?,?)',[idStudent,name,lastName,age,email],(err)=>{
                            if(!err){
                                resolve({StatusCode:200,Message:'Sucesss'})
                            }else{
                                reject(err)
                            }
                        })
                    }else{
                        reject(errConn)
                    }
                } catch (error) {
                }
            })
        })
    }
    GetAllStudents(){
        return new Promise((resolve,reject)=>{
            mysqlConnection.getConnection(function(errConn,conn){
                try {
                    if(!errConn){
                        conn.query('SELECT * FROM estudiantes',(err,rows)=>{
                            if(!err){
                                resolve({StatusCode:200,Message:'Sucesss', Data: rows})
                            }else{
                                reject(err)
                            }
                        })
                    }else{
                        reject(errConn)
                    }
                } catch (error) {
                }
            })
        })
    }
    GetAllCareers(){
        return new Promise((resolve,reject)=>{
            const query="SELECT * FROM carreras INNER JOIN detalle_clases ON detalle_clases.nombrecarrera=carreras.nombrecarrera INNER JOIN clases ON detalle_clases.nombreclase=clases.nombreclase"
            mysqlConnection.getConnection(function(errConn,conn){
                try {
                    if(!errConn){
                        conn.query(query,(err,rows)=>{
                            if(!err){
                                resolve({StatusCode:200,Message:'Sucesss', Data: rows})
                            }else{
                                reject(err)
                            }
                        })
                    }else{
                        reject(errConn)
                    }
                } catch (error) {
                }
            })
        })
    }
    GetStudenById(idStudent, Email){
        return new Promise((resolve,reject)=>{
            mysqlConnection.getConnection(function(errConn,conn){
                try {
                    if(!errConn){
                        conn.query('SELECT * FROM estudiantes WHERE idestudiante=? OR Correo=?',[String(idStudent),String(Email)],(err,rows)=>{
                            if(!err){
                                resolve({StatusCode:200,Message:'Sucesss', Data: rows})
                            }else{
                                reject(err)
                            }
                        })
                    }else{
                        reject(errConn)
                    }
                } catch (error) {
                }
            })
        })
    }
    GetInformationClass(classname){
        return new Promise((resolve,reject)=>{
            mysqlConnection.getConnection(function(errConn,conn){
                try {
                    if(!errConn){
                        conn.query('CALL granInnerJoin(?)',[classname],(err,rows)=>{
                            if(!err){
                                resolve({StatusCode:200,Message:'Sucesss', Data: rows[0]})
                            }else{
                                reject(err)
                            }
                        })
                    }else{
                        reject(errConn)
                    }
                } catch (error) {
                }
            })
        })
    }
}
module.exports=new StudentService()