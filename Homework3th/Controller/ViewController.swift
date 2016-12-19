//
//  ViewController.swift
//  Homework3th
//
//  Created by Chamroeun Chun on 12/18/16.
//  Copyright © 2016 Chamroeun Chun. All rights reserved.
//

import UIKit
protocol ArticalProtocol {
    func responseDatas(_ data:[Article])
    func articlePosted()

}
class ViewController: UIViewController {
    var articles = [Article]()
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

