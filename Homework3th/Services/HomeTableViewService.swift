//
//  HomeTableViewService.swift
//  Homework3th
//
//  Created by CHAMROEUN CHUN on 12/19/16.
//  Copyright © 2016 Chamroeun Chun. All rights reserved.
//

import Foundation
class HomeTableViewService {
    
    //  Mark Instance
    var articles = [Article]()
    var homeTableViewPresenterInterface: HomeTableViewPresenterInterface?
    
    //  Mark Function Fetch Data
    func fetchData(page: Int, limit: Int) {
        let url = URL(string:  "\(Constant.GlobalConstants.ARTICLE)?page=\(page)&limit=\(limit)")
        var request = URLRequest(url: url!)
        request.setValue("\(Constant.GlobalConstants.headers)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let getTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil {
                
                print(error!)
                
            } else {
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                        
                        
                        let jsonData = jsonResult["DATA"] as! [AnyObject]
                        for responseData in jsonData {
                            
                            self.articles.append(Article(JSON: responseData as! [String : Any])!)
                        }
                        
                        //  Notify to presenter
                        self.homeTableViewPresenterInterface?.responseData(data: self.articles)
                        
                    } catch {
                        
                        print("JSON Processing Failed")
                        
                    }
                }
            }
        }
        getTask.resume()
    }

    //  Mark Function Delete Data
    func deleteData(id: Int) {
        
        let url = URL(string: "\(Constant.GlobalConstants.ARTICLE)/\(id)")

        var request = URLRequest(url: url!)
        request.setValue("\(Constant.GlobalConstants.headers)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let deleteTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil {
                
                print(error?.localizedDescription as Any)
                
            } else {
                
                if data != nil {
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response)")
                        
                    }
                    self.homeTableViewPresenterInterface?.DeleteContentSuccess(withMessage: "Delete Success")
                    self.articles.removeAll()
                    self.fetchData(page: 1, limit: 15)
                    
                }
            }
        }
        deleteTask.resume()
    }
    
}
