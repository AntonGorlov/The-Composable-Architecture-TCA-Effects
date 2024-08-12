//
//  CharactersResultsResponseData.swift
//  Effects
//
//  Created by Anton Gorlov on 05.08.2024.
//

import Foundation

/// Response data
struct CharactersResultsResponseData: Decodable {
    
    let results: [PersonResponseData]
}

