//
//  TodoItemDetailViewController.swift
//  TodoList_app
//
//  Created by Sun Huanji on 2016/11/18.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit

class TodoItemDetailViewController: UIViewController {
    
    var todoItemToEdit:todoItem?
    var todoList:todoList?
    @IBOutlet weak var todoItemTextField: UITextField!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {
        
        if let item = todoItemToEdit {
            item._content = todoItemTextField.text!
            item.updateTodoItem(todoListId: (todoList?._id)!,
                success: {
                    print("success update")
            },
                failure: {error in
                    print("fail update")
                    print(error as Any)
            })
            dismiss(animated: true, completion: nil)
        } else {
            let item = todoItem(content: "", id: 0)
            item._content = todoItemTextField.text!
            item.createTodoItem(todoListId: (todoList?._id)!,
                success: {
                print("success post")
            }, failure: { (error) in
                print("fail post")
            })
            dismiss(animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = todoItemToEdit{
            title = "Edit TodoItem"
            todoItemTextField.text = item._content
            saveButton.isEnabled = true
        }
     // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
