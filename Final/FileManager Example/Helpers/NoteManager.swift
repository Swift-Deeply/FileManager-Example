//
//  NoteManager.swift
//  FileManager Example
//
//  Created by Can Balkaya on 1/2/21.
//

import Foundation

class NoteManager {
    
    // MARK: - Properties
    private let dataSourceURL: URL
    private var allNotes: [Note] {
        get {
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: dataSourceURL)
                let decodedNotes = try! decoder.decode([Note].self, from: data)
                
                return decodedNotes
            } catch {
                return []
            }
        }
        set {
            do {
                let encoder = PropertyListEncoder()
                let data = try encoder.encode(newValue)
                
                try data.write(to: dataSourceURL)
            } catch {
                
            }
        }
    }
    
    // MARK: - Life Cycle
    init() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let notesPath = documentsPath.appendingPathComponent("notes").appendingPathExtension("plist")
        
        dataSourceURL = notesPath
    }
    
    // MARK: - Functions
    func getAllNotes() -> [Note] {
        return allNotes
    }
    
    func create(note: Note) {
        allNotes.insert(note, at: 0)
    }
    
    func setComplete(note: Note, index: Int) {
        allNotes[index] = note
    }
    
    func delete(note: Note) {
        if let index = allNotes.firstIndex(where: { $0.id == note.id }) {
            allNotes.remove(at: index)
        }
    }
}
