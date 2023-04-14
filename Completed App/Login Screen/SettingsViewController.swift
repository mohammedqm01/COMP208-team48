//
//  SettingsViewController.swift
//  COMP208_Study_Calendar
//
//  Created by Kai Farrimond on 29/03/2023.
//

import UIKit

var selectedDaysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
var selectedDaysCount = selectedDaysOfWeek.count

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource
{
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studyDaysSelection.dequeueReusableCell(withIdentifier: "daySelectionCell", for: indexPath)
        var content = UIListContentConfiguration.cell()
        content.text = daysOfWeek[indexPath.row]
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        
        if selectedDaysOfWeek.contains(content.text!) {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if studyDaysSelection.cellForRow(at: indexPath)?.accessoryType != .checkmark {
            studyDaysSelection.cellForRow(at: indexPath)?.accessoryType = .checkmark
            selectedDaysOfWeek[indexPath.row] = daysOfWeek[indexPath.row]
            selectedDaysCount += 1
            
        }
        else {
            studyDaysSelection.cellForRow(at: indexPath)?.accessoryType = .none
            selectedDaysOfWeek[indexPath.row] = " "
            selectedDaysCount -= 1
        }
        
        for day in selectedDaysOfWeek {
            print(day)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hourPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hourPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        studyHours = Double(hourPickerData[row])!
    }
    
    
    @IBOutlet weak var studyHoursPicker: UIPickerView!
    @IBOutlet weak var studyDaysSelection: UITableView!
    
    
    
    
    var hourPickerData = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for hour in subjectList.count + 1...40 {
            hourPickerData.append(String(hour))
        }
        
        let currentRow = Int(studyHours) - subjectList.count - 1
        studyHoursPicker.selectRow(currentRow, inComponent: 0, animated: true)
    }
}
