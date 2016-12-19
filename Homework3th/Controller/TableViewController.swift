//
//  TableViewController.swift
//  Homework3th
//
//  Created by Chamroeun Chun on 12/18/16.
//  Copyright © 2016 Chamroeun Chun. All rights reserved.
//

import UIKit

import Kingfisher

protocol HomeTableViewInterface {
    func articleLoad(article: [Article])
    func articlePosted()
    func deleteData(id: Int)
    func DeleteContentSuccess(withMessage message:String)
}

class HomeTableViewController: UITableViewController {
    
    //  Mark Object
    var eventHandler: HomeTableViewPresenter!
    var articles = [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventHandler = HomeTableViewPresenter()
        
        eventHandler.articleLoad(viewInterface: self)
        
        
        eventHandler.fetchData(page: 1, limit: 15)
    }
}

extension HomeTableViewController: HomeTableViewInterface {
    internal func DeleteContentSuccess(withMessage message: String) {
        print(message)
    }
    
    internal func deleteData(id: Int) {
        eventHandler.deleteData(id: id)
    }
    
    
    internal func articlePosted() {
        self.tableView.reloadData()
    }
    
    // final step
    func articleLoad(article: [Article]) {
        if article.count > 0 {
            self.articles = article
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}


//  Mark UITableViewControllerDataSource
extension HomeTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableCell", for: indexPath) as! TableViewCell1
        
        // CustomCell
        cell.customCell(article: articles[indexPath.row])
        
        // print("articles.count \(articles.count)")
        
        return cell
    }
}

//  Mark Segue
extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // customize row swapping to show more button
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        func delete() {
            var articleToDelete: Article!
            articleToDelete = articles[indexPath.row]
            if let article = articleToDelete {
                
                deleteData(id: article.id!)
                tableView.reloadData()
                print("IDDD: ", article.id!)
            }
        }
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler:{action, indexpath in
            delete()
        });
        
        return [deleteRowAction];
    }

}
