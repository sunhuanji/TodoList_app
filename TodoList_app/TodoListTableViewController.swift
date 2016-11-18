//
//  TodoListTableViewController.swift
//  TodoList_app
//
//  Created by Sun Huanji on 2016/11/15.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TodoListTableViewController: UITableViewController {
    
   // var todoLists = [todoList(title:"ios",id:1),todoList(title:"ruby",id:2)]
    var todoLists = [todoList]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TodoListTableViewController.onRefresh(sender:)), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl

    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoLists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath) as! TodoListTableViewCell
            
            cell.todoListTitle.text = todoLists[indexPath.row]._title

        return cell
    }


//    func getTodoList(completed:@escaping DownloadComplete){
//        Alamofire.request("http://localhost:3000/todo_lists.json").responseJSON { (response) in
//            if let values = response.result.value{
//                let json = JSON(values)
//                let list = json.array!
//                self.todoLists = []
//                for obj in list{
//                  let title = obj["title"].string!
//                  let id = obj["id"].int!
//                  let todolist = todoList(title: title, id: id)
//                  self.todoLists.append(todolist)
//                  self.tableView.reloadData()
//                  self.refreshControl?.endRefreshing()
//                }
//            }
//            //completed()
//        }
//    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let navigationController = storyboard!.instantiateViewController(withIdentifier: "TodoListDetail") as! UINavigationController
        let controller = navigationController.topViewController as! TodoListDetailViewController
        
        controller.todoListToEdit = todoLists[indexPath.row]
        
        present(navigationController, animated: true, completion: nil)
    }

    
    func refreshData() {
        todoList.getTodoLists(
            success: {(todoLists) -> Void in
                self.todoLists = todoLists.reversed()
                self.tableView.reloadData()
        },
            failure: {(error) -> Void in
                // エラー処理
                let alertController = UIAlertController(
                    title: "エラー",
                    message: "エラーメッセージ",
                    preferredStyle: .alert)
                alertController.addAction(UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: nil))
                self.present(alertController, animated: true, completion: nil)
        })
    }
    
    func onRefresh(sender: UIRefreshControl) {
        refreshControl?.beginRefreshing()
        todoList.getTodoLists(
            success: {(todoLists) -> Void in
                self.todoLists = todoLists.reversed()
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
        },
            failure: {(error) -> Void in
                // エラー処理
                let alertController = UIAlertController(
                    title: "エラー",
                    message: "エラーメッセージ",
                    preferredStyle: .alert)
                alertController.addAction(UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: nil))
                self.present(alertController, animated: true, completion: nil)
                self.refreshControl?.endRefreshing()
        })
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todolist = self.todoLists[indexPath.row]
            todolist.deleteTodoList(
                success: {
                    print("success delete")
                    self.todoLists.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)

                },
                failure: {
                    (error) in
                    print("fail delete")
                    print(error as Any)
             }
        )
      }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddTodoList" {
            
//            let navigationController = segue.destination as! UINavigationController
//            
//            let controller = navigationController.topViewController as! TodoListDetailViewController
            
           // controller.delegate = self
            
        }else if segue.identifier == "ShowTodoList" {
            
            let navigationController = segue.destination as! UINavigationController
            
            let controller = navigationController.topViewController as! TodoItemTableViewController
            
            controller.todoList = todoLists[(tableView.indexPathForSelectedRow!.row)]
            
        }
    }
    

}
