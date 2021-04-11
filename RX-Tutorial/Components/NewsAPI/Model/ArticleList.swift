//
//  ArticleList.swift
//  RX-Tutorial
//
//  Created by David Adel on 07/04/2021.
//

import Mapper

struct ArticleList: Decodable {
    let status: String
    let articles: [Article]
}


extension ArticleList {
    static var all: Resource<ArticleList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=5da4e98e59ff40c8b4fe299952005d0e")!
        return Resource(url: url)
    }()
}
