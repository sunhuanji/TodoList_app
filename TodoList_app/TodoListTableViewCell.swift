//
//  TodoListTableViewCell.swift
//  TodoList_app
//
//  Created by Sun Huanji on 2016/11/15.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {

    @IBOutlet weak var todoListTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
