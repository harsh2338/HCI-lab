const { mongoose } = require('./db')
const express = require('express');
const bodyParser = require('body-parser')
const employeeController = require('./controllers/employee_controller')
var cors = require('cors');

const app = express()
const PORT = 3000;
app.use(cors());

app.use(bodyParser.json())


app.listen(PORT, () => console.log('Server started'));
app.use('/employee', employeeController)