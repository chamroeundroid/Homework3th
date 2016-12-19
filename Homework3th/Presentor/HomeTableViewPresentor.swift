//
//  HomeTableViewPresentor.swift
//  Homework3th
//
//  Created by CHAMROEUN CHUN on 12/19/16.
//  Copyright © 2016 Chamroeun Chun. All rights reserved.
//

import Foundation

protocol HomeTableViewPresenterInterface {
    func responseData(data: [Article])
    func DeleteContentSuccess(withMessage message: String)
}

class HomeTableViewPresenter: HomeTableViewPresenterInterface {

    var homeTableViewInterface: HomeTableViewInterface?
    var homeTableViewService: HomeTableViewService?
    
    func articleLoad(viewInterface: HomeTableViewInterface) {
        
        homeTableViewInterface = viewInterface
        homeTableViewService = HomeTableViewService()
        homeTableViewService?.homeTableViewPresenterInterface = self
    }
    
    func fetchData(page: Int, limit: Int) {
        homeTableViewService?.fetchData(page: page, limit: limit)
    }
    
    func deleteData(id: Int) {
        homeTableViewService?.deleteData(id: id)
    }
    func responseData(data: [Article]) {
        homeTableViewInterface?.articleLoad(article: data)
    }
    
    func DeleteContentSuccess(withMessage message: String) {
        homeTableViewInterface?.DeleteContentSuccess(withMessage: message)
    }
    
    
}
