const express = require('express');
var router = express.Router();
var ObjectId = require('mongoose').Types.ObjectId;

var { Employee } = require('../models/employee.model');

router.get('/', (req, res) => {
    Employee.find((err, docs) => {
        if (!err) { res.send(docs); } else { console.log('Error in Retriving Employees :' + JSON.stringify(err, undefined, 2)); }
    });
});

router.get('/:id', (req, res) => {
    if (!ObjectId.isValid(req.params.id))
        return res.status(400).send(`No record with given id : ${req.params.id}`);

    Employee.findById(req.params.id, (err, doc) => {
        if (!err) {
            res.send(doc);
        } else {
            console.log('Error in Retriving Employee :' + JSON.stringify(err, undefined, 2));
        }
    });
});

router.post('/', (req, res) => {
    var emp = new Employee({
        employee_id: req.body.employee_id,
        name: req.body.name,
        position: req.body.position,
        department: req.body.department,
        salary: req.body.salary,
        conduct: req.body.conduct,
        quality: req.body.quality,
        teamwork: req.body.teamwork,
        skill: req.body.skill,
    });
    emp.save((err, doc) => {
        if (!err) {
            res.send(doc);
            console.log("Data added")
        } else {
            console.log('Error in Employee Save :' + JSON.stringify(err, undefined, 2));
        }
    });
});

router.put('/:id', (req, res) => {
    if (!ObjectId.isValid(req.params.id))
        return res.status(400).send(`No record with given id : ${req.params.id}`);

    var emp = {
        employee_id: req.body.employee_id,
        name: req.body.name,
        position: req.body.position,
        department: req.body.department,
        salary: req.body.salary,
        conduct: req.body.conduct,
        quality: req.body.quality,
        teamwork: req.body.teamwork,
        skill: req.body.skill,
    };
    Employee.findByIdAndUpdate(req.params.id, { $set: emp }, { new: true }, (err, doc) => {
        if (!err) {
            res.send(doc);
        } else {
            console.log('Error in Employee Update :' + JSON.stringify(err, undefined, 2));
        }
    });
});

router.delete('/:id', (req, res) => {
    console.log("Recv")
    if (!ObjectId.isValid(req.params.id))
        return res.status(400).send(`No record with given id : ${req.params.id}`);

    Employee.findByIdAndRemove(req.params.id, (err, doc) => {
        if (!err) {
            console.log("DEleted")
            res.send(doc);
        } else {
            console.log('Error in Employee Delete :' + JSON.stringify(err, undefined, 2));
        }
    });
});

module.exports = router;