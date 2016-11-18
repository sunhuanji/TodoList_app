//
//  TodoListDetailViewController.swift
//  TodoList_app
//
//  Created by Sun Huanji on 2016/11/16.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit

protocol TodoListDetailViewControllerDelegate:class{
//    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
//    func itemDetailViewController(_ controller:ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
//    func itemDetailViewController(_ controller:ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}

class TodoListDetailViewController: UIViewController {
    
    //weak var delegate:TodoListDetailViewControllerDelegate?
    var todoListToEdit:todoList?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func save(_ sender: Any) {
        if let item = todoListToEdit {
            item._title = todoListTitle.text!
            item.updateTodoList(
                success: {
                print("success update")
            },
            failure: {error in
                      print("fail update")
                print(error as Any)
            })
             dismiss(animated: true, completion: nil)
        } else {
            let item = todoList(title: "", id: 0)
            item._title = todoListTitle.text!
            item.createTodoList(
                success: {
                print("success update")
            },
                failure: {error in
                print("fail update")
                print(error as Any)
            })
             dismiss(animated: true, completion: nil)
        }
        
//        todoListToEdit?._title = todoListTitle.text
//        todoListToEdit?.updateTodoList(
//            success: {
//            print("success update")
//             },
//            failure: {error in
//            print("fail update")
//            print(error)
//         }
//      )
//        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var todoListTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      if let item = todoListToEdit{
            title = "Edit TodoList"
            todoListTitle.text = item._title
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
