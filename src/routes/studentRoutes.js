const express=require('express')
const studentController = require('../controllers/studentController')
const router=express.Router()
router.get('/GetUserById/:idStudent/:email',studentController.GetStudentById)
router.post('/InsertStudent',studentController.InsertStudent)
router.put('/UpdateStudent',studentController.UpdateStudent)
router.get('/GetAllStudents',studentController.GetAllStudents)
router.get('/GetInformationClass/:classname',studentController.GetInformationClass)
module.exports=router