//
//  Task.swift
//  RX-Tutorial
//
//  Created by David Adel on 07/04/2021.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct TaskModel {
    let title: String
    let priority: Priority
}
