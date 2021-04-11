//
//  Article.swift
//  RX-Tutorial
//
//  Created by David Adel on 07/04/2021.
//

import Mapper

struct Article: Decodable {
    let title: String
    let description: String?
}
