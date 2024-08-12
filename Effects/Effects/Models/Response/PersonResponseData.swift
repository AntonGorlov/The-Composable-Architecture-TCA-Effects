//
//  PersonResponseData.swift
//  Effects
//
//  Created by Anton Gorlov on 05.08.2024.
//

import Foundation

struct PersonResponseData: Decodable {
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: LocationCharacter
}

