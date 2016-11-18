//
//  todo_item.swift
//  TodoList_app
//
//  Created by Sun Huanji on 2016/11/15.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class todoItem {
    
   var _id:Int!
   var _content:String!
    //private var _completed:Bool!
    
    init(content:String, id:Int) {
        self._id = id
        self._content = content
        
    }
    
    class func getTodoItems(todoListId:Int, success: @escaping ([todoItem]) -> Void, failure: @escaping (NSError?) -> Void) {
        Alamofire.request("http://localhost:3000/todo_lists/\(todoListId)/todo_items.json").responseJSON { response in
            if let error = response.result.error {
                failure(error as NSError?)
                return
            }
            var todoitems = [todoItem]()
//            if let values = response.result.value{
//                let json = JSON(values)
//                let items = json["todo_items"]
//                let list = items.array!
//                for obj in list{
//                    let content = obj["content"].string!
//                    let id = obj["id"].int!
//                    let todoitem = todoItem(content: content, id: id)
//                    todoitems.append(todoitem)
//                    
//                }
//            }
            
            if let values = response.result.value{
                let json = JSON(values)
                let list = json.array!
                for obj in list{
                    let content = obj["content"].string!
                    let id = obj["id"].int!
                    let todoitem = todoItem(content: content, id:id)
                    todoitems.append(todoitem)
                }
            }
            success(todoitems)
            return
        }
    }
    
    func deleteTodoItem(todoListId:Int,success: @escaping (Void) -> Void, failure: @escaping (NSError?) -> Void) {
        Alamofire.request("http://localhost:3000/todo_lists/\(todoListId)/todo_items/\(self._id!).json",method:.delete).responseJSON { response in
            print("http://localhost:3000/todo_lists/\(todoListId)/todo_items/\(self._id!).json")
            if let error = response.result.error {
                failure(error as NSError?)
                return
            }
            success()
            return
        }
    }
    
    func updateTodoItem(todoListId:Int,success: @escaping (Void) -> Void, failure: @escaping (NSError?) -> Void) {
        
        let params:Parameters = [
            "content" : self._content!
        ]
        print("http://localhost:3000/todo_lists/\(todoListId)/todo_items/\(self._id!).json")
        
        Alamofire.request("http://localhost:3000/todo_lists/\(todoListId)/todo_items/\(self._id!).json", method: .patch, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("\(status)")
                    }
                }
                //to get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print(JSON)
                }
                
        }
    }
    
    func createTodoItem(todoListId:Int, success: @escaping (Void) -> Void, failure: @escaping (NSError?) -> Void) {
        
        let params:Parameters = [
            "content" : self._content!
        ]
        
        Alamofire.request("http://localhost:3000/todo_lists/\(todoListId)/todo_items.json", method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                    print("\(status)")
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
