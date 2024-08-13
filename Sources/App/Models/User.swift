//
//  File.swift
//  
//
//  Created by Mike Jasso on 13/08/24.
//

import Foundation
import Vapor

struct User: Content {
    var id, age: Int
    var name, email: String
}
