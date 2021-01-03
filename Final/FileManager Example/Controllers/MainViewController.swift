//
//  MainViewController.swift
//  FileManager Example
//
//  Created by Can Balkaya on 12/29/20.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var noteManager = NoteManager()
    
    // MARK: - Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteManager.getAllNotes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteTableViewCell
        let note = noteManager.getAllNotes()[indexPath.row]
        cell!.prepare(with: note)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let ac = UIAlertController(title: "Change your note!", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addTextField()
        ac.textFields![0].text = noteManager.getAllNotes()[indexPath.row].title
        ac.textFields![1].text = noteManager.getAllNotes()[indexPath.row].description

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let changeAction = UIAlertAction(title: "Change", style: .default) { [self, unowned ac] _ in
            let title = ac.textFields![0].text!
            let description = ac.textFields![1].text!
            let note = Note(title: title, description: description)
            
            self.noteManager.setComplete(note: note, index: indexPath.row)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }

        ac.addAction(cancelAction)
        ac.addAction(changeAction)
        
        present(ac, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let noteToDelete = noteManager.getAllNotes()[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completed) in
            completed(true)
            self.noteManager.delete(note: noteToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Write a note!", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addTextField()
        ac.textFields![0].placeholder = "Title"
        ac.textFields![1].placeholder = "Description"

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let submitAction = UIAlertAction(title: "Save", style: .default) { [self, unowned ac] _ in
            let title = ac.textFields![0].text!
            let description = ac.textFields![1].text!
            let note = Note(title: title, description: description)
            
            self.noteManager.create(note: note)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let newIndexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }

        ac.addAction(cancelAction)
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
}
