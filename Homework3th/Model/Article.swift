//
//  Article.swift
//  Homework3th
//
//  Created by Chamroeun Chun on 12/18/16.
//  Copyright © 2016 Chamroeun Chun. All rights reserved.
//

import Foundation
import ObjectMapper
public class Article:Mappable{
    var id:Int?
    var title:String?
    var description:String?
    var image:String?
    
    required public init?(map: Map) {
        mapping(map: map)
    }
}
public class Pagination {
    var page = 1
    var total = 1
    static let paginationObject = Pagination()
    init (){}
}
extension Article {
    public func mapping(map: Map) {
        id  <- map["ID"]
        title <- map["TITLE"]
        description <- map["DESCRIPTION"]
        image <- map["IMAGE"]
    }
}
