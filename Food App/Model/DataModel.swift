//
//  DataModel.swift
//  Food App
//
//  Created by marlon arteaga on 14/09/23.
//

import Foundation

class DataModel: Codable, Identifiable {
    var id: Int?
    var name: String?
    var tagline: String?
    var first_brewed: String?
    var description: String?
    
    init(id: Int? = nil, name: String? = nil, tagline: String? = nil, first_brewed: String? = nil, description: String? = nil) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.first_brewed = first_brewed
        self.description = description
    }
}
