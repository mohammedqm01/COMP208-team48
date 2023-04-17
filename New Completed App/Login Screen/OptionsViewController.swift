//
//  OptionsViewController.swift
//  COMP208_Study_Calendar
//
//  Created by Kai Farrimond on 28/03/2023.
//

import UIKit

var studyHours = 40.0
var days = [String]()

class OptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var newSubjectField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveSubject(_ sender: Any)
    {
        let newSubject = Subject()
        newSubject.id = subjectList.count
        newSubject.name = newSubjectField.text
        newSubject.ranking = subjectList.count + 1
        newSubject.allocatedHours = 0
        newSubject.tempAllocatedHours = 0
        
        subjectList.append(newSubject)
        tableView.reloadData()
        calendarAlgorithm()
    }
    
    
    @IBAction func editRankings(_ sender: UIButton)
    {
        if tableView.isEditing {
            sender.setTitle("Edit Rankings", for: .normal)
            tableView.isEditing = false
            updateSubjectRankings()
            calendarAlgorithm()
        }
        else {
            sender.setTitle("Done Editing", for: .normal)
            tableView.isEditing = true
        }
    }
    
    
    func calendarAlgorithm()
    {
        var rankSum = 0
        var allocatedPercentage = 0.0
        
        for subject in subjectList {
            rankSum += subject.ranking
        }
        
        for subject in subjectList {
            let doubleRankSum = Double(rankSum)
            let doubleRanking = Double(subject.ranking)
            allocatedPercentage = doubleRanking / doubleRankSum
            subject.allocatedHours = Int(round(allocatedPercentage * studyHours))
            subject.tempAllocatedHours = subject.allocatedHours
        }
        
        days.removeAll()
        for subject in subjectList {
            for _ in 1...subject.tempAllocatedHours {
                days.append(subject.name)
            }
        }
        
        days.shuffle()
    }
    
    
    func updateSubjectRankings()
    {
        var i = 1
        
        for subject in subjectList {
            subject.ranking = i
            i+=1
        }
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        subjectList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath)
        var content = UIListContentConfiguration.cell()
        content.text = subjectList[indexPath.row].name
        cell.contentConfiguration = content
        return cell
    }
    
    
}
