//
//  ViewController.swift
//  COMP208_Study_Calendar
//
//  Created by Kai Farrimond on 27/03/2023.
//

import UIKit

var dailyHours = Int(studyHours) / selectedDaysCount

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var hours = [Int]()
    
    var currentDay = 0
    
    var daySelection = 0
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    func initTime()
    {
        hours.removeAll()
        for hour in 9...9 + dailyHours
        //for hour in 9...17
        {
            hours.append(hour)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return hours.count - 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourCell") as! EventCell
        let hour = hours[indexPath.row]
        cell.timeLabel.text = formatHour(hour: hour)
        
        if subjectList.isEmpty {
            cell.subjectLabel.text = "Add Subjects to Populate!"
        }
        else {
            let subject = days[indexPath.row + daySelection]
            cell.subjectLabel.text = subject
        }
        return cell
    }
    
    
    func formatHour(hour: Int) -> String
    {
        return String(format: "%02d:%02d", hour, 0)
    }
    
    
    @IBAction func prevDay(_ sender: Any)
    {
        if selectedDaysOfWeek.indices.contains(currentDay - 1) && selectedDaysOfWeek[currentDay - 1] != " " {
            
            currentDay -= 1
            
            while selectedDaysOfWeek[currentDay] == " " {
                currentDay -= 1
            }
            
            daySelection -= dailyHours
            
            dayLabel.text = selectedDaysOfWeek[currentDay]
            
            tableView.reloadData()
        }
    }
    
    
    @IBAction func nextDay(_ sender: Any)
    {
        if selectedDaysOfWeek.indices.contains(currentDay + 1) && selectedDaysOfWeek[currentDay + 1] != " " {
            
            currentDay += 1
            
            while selectedDaysOfWeek[currentDay] == " " {
                currentDay += 1
            }
            
            daySelection += dailyHours
            
            dayLabel.text = selectedDaysOfWeek[currentDay]
            
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dailyHours = Int(studyHours) / selectedDaysCount
        
        initTime()
        
        dayLabel.text = selectedDaysOfWeek[currentDay]
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dailyHours = Int(studyHours) / selectedDaysCount
        
        initTime()
        
        dayLabel.text = selectedDaysOfWeek[currentDay]
        
        tableView.reloadData()
    }


}

