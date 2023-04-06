//
//  StudyTimesViewController.swift
//  Weakness Analysis
//
//  Created by Kevon Rahimi on 29/03/2023.
//

import UIKit

class StudyTimesViewController: UITableViewController {
    

    var studyTimes: [String:Int] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StudyTimeCell")
        
        //Table view:
        tableView.dataSource = self
        tableView.delegate = self
        
        // Calculate study times function:
        studyTimes = calculateStudyTime(modulePercentages: modules, totalStudyHours: hours)
        tableView.reloadData()
        //Testing for to check if function remains working, hours should be indirectly proportionate to their score, remove once finished with this section:
        print(studyTimes)
    }
    
    func calculateStudyTime(modulePercentages: [String:Int], totalStudyHours: Int) -> [String:Int] {
        var studyTimes = [String:Int]()
        var totalPercentage = 0


        // Calculate total percentage
        for (_, percentage) in modulePercentages
        {
            totalPercentage += percentage
        }

        /* Calculate study time for each module indirectly proportionate to the percentage score
         * So the higher your score the less allocated revision time is for that module
         */
         var totalStudyTime = 0
        for (moduleName, percentage) in modulePercentages
        {
            let percentageOfTotal = Double(percentage) / Double(totalPercentage)
            let studyTime = Int(Double(totalStudyHours) * (1 / percentageOfTotal))
            totalStudyTime += studyTime
            studyTimes[moduleName] = studyTime
        }

        // Sort study times based on number of study hours
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
        studyTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(studyTimeLabel)
        
        // Constraints to move the studyTimeLabel to the right...Don't know if their is a better way to do this but this works
        studyTimeLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -15).isActive = true
        studyTimeLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        
        return cell
    }
}

