//
//  ViewController.swift
//  NoteTaking
//
//  Created by Cristian Luca on 15/03/2023.
//

import UIKit

class NoteEntry: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    var structure: [(title: String, note: String)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        title = "Notes"
    }
    @IBAction func didTapNewNote() {
        guard let viewCtr = storyboard?.instantiateViewController(withIdentifier: "new") as? NoteViewController else{
            return
        }
        viewCtr.completion = {
            noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
            self.structure.append((title: noteTitle, note: note))
            self.label.isHidden = true
            self.table.isHidden = false
            self.table.reloadData()
        }
        viewCtr.title = "New Note"
        navigationController?.pushViewController(viewCtr, animated: true)
    }
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return structure.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = structure[indexPath.row].title
        cell.detailTextLabel?.text = structure[indexPath.row].note
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Show note controller
        let model = structure[indexPath.row]
        guard let viewCtr = storyboard?.instantiateViewController(withIdentifier: "new") as? NoteViewController else {
            return
        }
        viewCtr.title = "notes"
        
        viewCtr.noteTitle = model.title
        viewCtr.noteContent = model.note
        viewCtr.completion = { [weak self] noteTitle, note in
                self?.navigationController?.popToRootViewController(animated: true)
                self?.structure[indexPath.row] = (title: noteTitle, note: note)
                self?.table.reloadData()
            }
        navigationController?.pushViewController(viewCtr, animated: true)
    }
}

