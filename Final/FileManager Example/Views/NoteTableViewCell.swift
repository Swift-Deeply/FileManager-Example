//
//  NoteTableViewCell.swift
//  FileManager Example
//
//  Created by Can Balkaya on 1/2/21.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Functions
    func prepare(with note: Note) {
        titleLabel.text = note.title
        descriptionLabel.text = note.description
    }
}
