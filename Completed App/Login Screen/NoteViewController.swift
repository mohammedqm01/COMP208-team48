//
//  EntryViewController.swift
//  NoteTaking
//
//  Created by Cristian Luca on 15/03/2023.
//

import UIKit

class NoteViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    public var completion: ((String, String) -> Void)?
    var noteTitle: String?
    var noteContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        titleField.delegate = self
        titleField.text = noteTitle
        noteField.text = noteContent
    }
    
    @objc func didTapSave() {
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            completion?(text, noteField.text)
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               textField.resignFirstResponder()
               return true
           }
    }
}
