//
//  todo_list.swift
//  TodoList_app
//
//  Created by Sun Huanji on 2016/11/15.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


class todoList {

     var _todoItems = [todoItem]()
     var _id:Int!
     var _title:String!
     var _description:String!

    
    
    init(title:String, id:Int) {
        self._title = title
        self._id = id
    }
    
    func deleteTodoList(success: @escaping (Void) -> Void, failure: @escaping (NSError?) -> Void) {
        Alamofire.request("http://localhost:3000/todo_lists/\(self._id!).json",method:.delete).responseJSON { response in
            print("http://localhost:3000/todo_lists/\(self._id!).json")
            if let error = response.result.error {
                failure(error as NSError?)
                return
            }
            success()
            return
        }
    }
    
    class func getTodoLists(success: @escaping ([todoList]) -> Void, failure: @escaping (NSError?) -> Void) {
        Alamofire.request("http://localhost:3000/todo_lists.json").responseJSON { response in
            if let error = response.result.error {
                failure(error as NSError?)
                return
            }
            
            var todolists = [todoList]()
            
            if let values = response.result.value{
                    let json = JSON(values)
                    let list = json.array!
                    for obj in list{
                        let title = obj["title"].string!
                        let id = obj["id"].int!
                        let todolist = todoList(title: title, id:id)
                        todolists.append(todolist)
                    }
            }
            success(todolists)
            return
        }
    }
    
    func updateTodoList(success: @escaping (Void) -> Void, failure: @escaping (NSError?) -> Void) {
        
        let params:Parameters = [
            "title" : self._title!
        ]
        print("http://localhost:3000/todo_lists/\(self._id!).json")
        
        Alamofire.request("http://localhost:3000/todo_lists/\(self._id!).json", method: .patch, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print(JSON)
                }
                
        }
    }
    
    func createTodoList(success: @escaping (Void) -> Void, failure: @escaping (NSError?) -> Void) {
        
        let params:Parameters = [
            "title" : self._title!
        ]
        
        Alamofire.request("http://localhost:3000/todo_lists.json", method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print(JSON)
                }
                
        }
    }
}
