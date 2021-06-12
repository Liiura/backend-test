const StudentService=require('../services/studentService')

class StudenController{
    async InsertStudent(req,res){
        try {
            const data=await StudentService.InsertStudent(req.body.idStudent,req.body.name,req.body.lastName,req.body.age,req.body.email)
            if(data.StatusCode===201){
                res.status(201)
            }
            res.json(data)
        } catch (error) {
            res.status(500)
            res.json({StatusCode:500, Message: 'Internal error', Error: error})
        }
    }
    async UpdateStudent(req,res){
        try {
            const data=await StudentService.UpdateStudent(req.body.idStudent,req.body.name,req.body.lastName,req.body.age,req.body.email)
            res.json(data)
        } catch (error) {
            res.status(500)
            res.json({StatusCode:500, Message: 'Internal error', Error: error})
        }
    }
    async GetStudentById(req,res){
        try {
            const data=await StudentService.GetStudenById(req.params.idStudent,req.params.email)
            res.json(data)
        } catch (error) {
            res.status(500)
            res.json({StatusCode:500, Message: 'Internal error', Error: error})
        }
    }
    async GetAllStudents(req,res){
        try {
            const data=await StudentService.GetAllStudents()
            res.json(data)
        } catch (error) {
            res.status(500)
            res.json({StatusCode:500, Message: 'Internal error', Error: error})
        }
    }
    async GetInformationClass(req,res){
        try {
            const data=await StudentService.GetInformationClass(req.params.classname)
            res.json(data)
        } catch (error) {
            res.status(500)
            res.json({StatusCode:500, Message: 'Internal error', Error: error})
        }
    }


}
module.exports=new StudenController()