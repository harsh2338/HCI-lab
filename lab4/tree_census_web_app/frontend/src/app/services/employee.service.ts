import { Injectable } from '@angular/core';
import { HttpClient,HttpHeaders } from '@angular/common/http'

import { Employee } from '../models/employee.model';

@Injectable({
  providedIn: 'root'
})
export class EmployeeService {
  noAuthHeader = {
    headers: new HttpHeaders({
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET,POST,OPTIONS,DELETE,PUT',
      'NoAuth':'True'
    })
  };
  selectedEmployee: Employee;

  url="http://localhost:3000/employee";
  constructor(private http: HttpClient) { }

  addData(emp:Employee){
    console.log("sent")
    return this.http.post(this.url,emp,this.noAuthHeader)
  }

  getEmployees(){
    return this.http.get(this.url,this.noAuthHeader)
  }
  updateEmployee(emp: Employee) {
    return this.http.put(this.url + `/${emp._id}`, emp);
  }

  deleteEmployee(_id: string) {
    return this.http.delete(this.url + `/${_id}`);
  }
}
