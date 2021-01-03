//
//  Note.swift
//  FileManager Example
//
//  Created by Can Balkaya on 1/2/21.
//

import Foundation

struct Note: Codable {
    
    // MARK: - Properties
    var id = UUID().uuidString
    var title: String
    var description: String
}
