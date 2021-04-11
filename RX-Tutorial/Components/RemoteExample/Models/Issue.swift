//
//  Issue.swift
//  RX-Tutorial
//
//  Created by David Adel on 06/04/2021.
//

import Mapper
 
struct Issue: Mappable {
    
    let identifier: Int
    let number: Int
    let title: String
    let body: String
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try number = map.from("number")
        try title = map.from("title")
        try body = map.from("body")
    }
}
