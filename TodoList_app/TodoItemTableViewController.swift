//
//  TodoItemTableViewController.swift
//  TodoList_app
//
//  Created by Sun Huanji on 2016/11/17.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit

class TodoItemTableViewController: UITableViewController {
    
     var todoItemToShow = [todoItem]()
     var todoList:todoList?

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TodoItemTableViewController.onRefresh(sender:)), for: UIControlEvents.valueChanged)
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
        return todoItemToShow.count
    }

    func refreshData() {
        todoItem.getTodoItems(todoListId: (todoList?._id)!,
            success: {(todoItems) -> Void in
                self.todoItemToShow = todoItems.reversed()
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
        todoItem.getTodoItems(todoListId: (todoList?._id)!,
            success: {(todoItems) -> Void in
                self.todoItemToShow = todoItems.reversed()
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath) as! TodoItemTableViewCell
        
        cell.todoItemLabel.text = todoItemToShow[indexPath.row]._content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let navigationController = storyboard!.instantiateViewController(withIdentifier: "TodoItemDetail") as! UINavigationController
        let controller = navigationController.topViewController as! TodoItemDetailViewController
        
        controller.todoItemToEdit = todoItemToShow[indexPath.row]
        controller.todoList = todoList
        
        present(navigationController, animated: true, completion: nil)
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todoitem = self.todoItemToShow[indexPath.row]
            todoitem.deleteTodoItem(todoListId: (todoList?._id)!,
                success: {
                    print("success delete")
                    self.todoItemToShow.remove(at: indexPath.row)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddTodoItem" {
            
            let navigationController = segue.destination as! UINavigationController
            
            let controller = navigationController.topViewController as! TodoItemDetailViewController
            
            controller.todoList = todoList
            
        }
    }

}
