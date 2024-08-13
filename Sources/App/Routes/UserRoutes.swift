//
//  File.swift
//  
//
//  Created by Mike Jasso on 13/08/24.
//

import Foundation
import Vapor

private var users = [
    User(id: 1, age: 34, name: "Miguel", email: "dackerjasso@gmail.com"),
    User(id: 2, age: 40, name: "Juan", email: "Juan@gmail.com")
]

func userRoutes(_ app: Application) throws {
    app.group("user") { user in
        user.get { request -> [User] in
            return users
        }
        
        user.get(":id") { request -> User in
            guard let id = request.parameters.get("id", as: Int.self) else {
                throw Abort(.badRequest)
            }
            
            guard let user = users.first(where: {$0.id == id }) else {
                throw Abort(.notFound)
            }
            
            return user
        }
        
        user.post { request in
            let user = try request.content.decode(User.self)
            users.append(user)
            return HTTPStatus.ok
        }
        
        user.delete(":id") { request in
            guard let id = request.parameters.get("id", as: Int.self) else {
                throw Abort(.badRequest)
            }
            users.removeAll(where: {$0.id == id})
            return HTTPStatus.ok
        }
    }
}

