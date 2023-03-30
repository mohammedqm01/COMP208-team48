//
//  StudyTimesViewController.swift
//  Weakness Analysis
//
//  Created by Kevon Rahimi on 29/03/2023.
//

import UIKit

class StudyTimesViewController: UITableViewController {
    

    var modulePercentages: [String:Int] = [:]
    var studyTimes: [String:Int] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register the cell reuse identifier
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StudyTimeCell")
        
        // Set the data source and delegate for the table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Calculate the study times
        studyTimes = calculateStudyTime(modulePercentages: modules, totalStudyHours: hours)
        print(studyTimes)
        tableView.reloadData()
    }
    
    func calculateStudyTime(modulePercentages: [String:Int], totalStudyHours: Int) -> [String:Int] {
        var studyTimes = [String:Int]()
        var totalPercentage = 0


        // Calculate total percentage
        for (_, percentage) in modulePercentages {
            totalPercentage += percentage
        }

        // Calculate study time for each module indirectly proportionate to the percentage score
        var totalStudyTime = 0
        for (moduleName, percentage) in modulePercentages {
            let percentageOfTotal = Double(percentage) / Double(totalPercentage)
            let studyTime = Int(Double(totalStudyHours) * (1 / percentageOfTotal))
            studyTimes[moduleName] = studyTime
            totalStudyTime += studyTime
        }

        // Normalize study times based on the total number of study hours
        let ratio = Double(totalStudyHours) / Double(totalStudyTime)
        for (moduleName, studyTime) in studyTimes {
            studyTimes[moduleName] = Int(Double(studyTime) * ratio)
        }

        return studyTimes
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyTimes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTimeCell", for: indexPath)
        let moduleName = Array(studyTimes.keys)[indexPath.row]
        let studyTime = studyTimes[moduleName] ?? 0
        cell.textLabel?.text = moduleName
        // Create a new UILabel for the study time and add it to the cell's contentView
        let studyTimeLabel = UILabel()
        studyTimeLabel.text = "\(studyTime) hours"
        studyTimeLabel.textColor = .gray
        studyTimeLabel.font = UIFont.systemFont(ofSize: 12)
        studyTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(studyTimeLabel)
        
        // Add constraints to position the label to the right of the cell
        studyTimeLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -15).isActive = true
        studyTimeLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        
        return cell
    }
}

