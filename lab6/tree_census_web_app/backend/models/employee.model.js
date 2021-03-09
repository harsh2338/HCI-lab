const mongoose = require('mongoose');

var Employee = mongoose.model('Employee', {
    employee_id: { type: Number },
    name: { type: String },
    position: { type: String },
    department: { type: String },
    salary: { type: Number },
    conduct: { type: Number },
    teamwork: { type: Number },
    quality: { type: Number },
    skill: { type: Number },


});

module.exports = { Employee };