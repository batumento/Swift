//
//  File.swift
//  Todoey
//
//  Created by Batuhan Emiroğlu on 16.07.2024.
//

import Foundation

class Item: Codable {
    var title : String
    var check : Bool

    init(title: String, check: Bool = false) {
        self.title = title
        self.check = check
    }
}
