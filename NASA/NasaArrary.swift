//
//  NasaArrary.swift
//  NASA
//
//  Created by 邱冠儒 on 2019/7/25.

//

import Foundation
struct Nasa: Codable {
    var title: String
    var explanation: String
    var url: URL
    var copyright: String?
    var date: String
    
    // Json 初始化物件字典
    init?(json: [String: String]) {
        guard let title = json["title"],
            let description = json["explanation"],
            let urlString = json["url"],
            let photoDate = json["date"],
            let url = URL(string: urlString) else { return nil }
        
        self.title = title
        self.explanation = description
        self.url = url
        self.date = photoDate
        self.copyright = json["copyright"]
        
    }
    
//Json tree structure
//    struct NasaResults: Codable {
//        var resultCount: Int
//        var results: [Nasa]
//    }
//
    
    
}


//Json tree structure 同上其實可以寫在外面 
struct NasaResults: Codable {
    var resultCount: Int
    var results: [Nasa]
}


