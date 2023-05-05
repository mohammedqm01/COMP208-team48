//
//  TaskReminderViewController.swift
//  Login Screen
//
//  Created by Shrog Alowaifeer on 15/04/2023.
//

import UIKit

class TaskReminderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func didTapAdd(_ sender: Any) {
        // show add vc
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "add") as? AddViewController else{
            return
        }
        vc.title = "New Task"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let newRemider = myReminder(title: title, date: date, identifier: "id_\(title)")
                self.models.append(newRemider)
                self.table.reloadData()
                
                // notification contenet
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                content.sound = .default
                content.badge = 1
                //to pass any type of data as dictionary (it can be used to take the user to specific page )
                content.userInfo = ["name": "test name"]
                
                
                // notification trigger
                let date = date
                
                let dateComponent = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
                
                // request
                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuidString , content: content, trigger: trigger)
                
                // Register the request
                UNUserNotificationCenter.current().add(request)
                
                // call save function to save added info
                self.saveTasks()

                
            }
            
        }
        
        navigationController?.pushViewController(vc, animated: true)
    
    }
    
    //A table to store the taks
    @IBOutlet weak var table: UITableView!
    
    // A refrence to hold the stract info
    var models = [myReminder]()
    
    let defaults = UserDefaults.standard
    let modelsKey = "models_task"
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        let date = models[indexPath.row].date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY at hh:mm a"
        cell.detailTextLabel?.text = formatter.string(from: date)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, veiw , completionHandler) in
            self.models.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            self.saveTasks()
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        
        // load the saved tasks
        loadSavedTasks()
        
        // check for any saved tasks
        checkSavedTasks()
    }
    
    
    func userNotification(){
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound ]) {
            (granted, error) in
            if granted {
                // schadule test
                self.notificationContenet()
            }
            else if error != nil{
                print("Error occurred")
            }
            
        }
                
    }
    
    func notificationContenet() {
        // notification contenet
        let content = UNMutableNotificationContent()
        content.title = "My Title"
        content.body = "My body"
        content.sound = .default
        content.badge = 1
        //to pass any type of data as dictionary
        content.userInfo = ["name": "test name"]
        
        
        // notification trigger
        let date = Date().addingTimeInterval(5)
        
        let dateComponent = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        // request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString , content: content, trigger: trigger)
        
        // Register the request
        UNUserNotificationCenter.current().add(request)


    }
    
    
    func saveTasks() {
        do {
            let encodedData = try JSONEncoder().encode(models)
            defaults.set(encodedData, forKey: modelsKey)
            
        } catch {
            print("Error encoding models: \(error.localizedDescription)")
        }
    }

    func loadSavedTasks() {
        if let savedData = UserDefaults.standard.data(forKey: "models_task"),
            let savedModels = try? JSONDecoder().decode([myReminder].self, from: savedData) {
            self.models = savedModels
            self.table.reloadData()
        }
    }

    func checkSavedTasks() {
        let taskAdded = UserDefaults.standard.object(forKey: "models_task")
        if taskAdded != nil {
            print("Tasks were added previously")
        }
    }

    
    struct myReminder: Codable {
        let title: String
        let date: Date
        let identifier: String
    }
}

