const express= require('express')
const app =express()
const cors=require("cors")
app.set('port',process.env.PORT || 5000)
app.use(express.json())
app.use(cors());
app.use('/api/student',require('./routes/studentRoutes'))
app.listen(app.get("port"),()=>{
    console.log('server on port',app.get("port"))
})
