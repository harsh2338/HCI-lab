const mongo = require("mongoose");
require('dotenv').config()
const uri = `mongodb://localhost:27017/employee`;
mongo.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex: true, useFindAndModify: false }, () => {
    console.log("connected to db");
});

require('./models/employee.model')
module.exports = mongo