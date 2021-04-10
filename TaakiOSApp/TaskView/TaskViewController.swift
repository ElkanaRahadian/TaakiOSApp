//
//  TaskViewController.swift
//  TaakiOSApp
//
//  Created by Apriliani Putri Prasetyo on 05/04/21.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskSearchBar: UISearchBar!
    @IBOutlet weak var taskTableView: UITableView!
    
    @IBAction func statusSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            statusSegment = "DONE"
            taskTableView.reloadData()
        default:
            statusSegment = "PENDING"
            taskTableView.reloadData()
        }
    }
    
//    var taskCollection = [TaskModel]()
    var statusSegment: String = "PENDING"
    
    var filteredData = [TaskModel]()
    var searching = false
    var selectedIndex = 0
    var taskName = ""
    var duration = 0
    
    var taskCollectionPending: [TaskModel] = [TaskModel(taskName: "Hi-Fi Prototype", estimateDuration: 120, status: "PENDING"), TaskModel(taskName: "Final Project", estimateDuration: 150, status: "PENDING")]
    var taskCollectionDone: [TaskModel] = [TaskModel(taskName: "Lo-Fi Prototype", estimateDuration: 60, status: "DONE"), TaskModel(taskName: "Self Learning", estimateDuration: 60, status: "DONE"), TaskModel(taskName: "Keynote Presentation", estimateDuration: 30, status: "DONE")]
    
    
//    var taskArray = ["Lo-Fi Prototype", "Hi-Fi Prototype", "Self Learning", "Skripsi", "Ujian Kalkulus"]
//    var durationArray = [60, 120, 60, 150, 120]
//    var statusArray = ["DONE", "PENDING", "DONE", "PENDING", "DONE"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configuration()
    }
    
    func configuration() {

        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        taskTableView.backgroundColor = #colorLiteral(red: 0.9359967113, green: 0.9867416024, blue: 0.9907793403, alpha: 1)
        taskTableView.backgroundView?.layer.cornerRadius = 10
        taskTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        taskSearchBar.delegate = self
//        taskSearchBar.becomeFirstResponder()
        taskSearchBar.backgroundImage = UIImage()
    }
    
    // function create data
//    func createData() {
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let manageContext = appDelegate.persistentContainer.viewContext
//
//        guard let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: manageContext) else { return }
//
//        for i in 1...taskArray.count {
//
//            let task = NSManagedObject(entity: taskEntity, insertInto: manageContext)
//            task.setValue(durationArray[i-1], forKey: "estimate_duration")
//            task.setValue(taskArray[i-1], forKey: "task_name")
//            task.setValue(statusArray[i-1], forKey: "status")
//        }
//    }
    
    
    // function retrieve data
//    func retrieveData(statusTask: String) {
//
//        taskCollection.removeAll()
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let manageContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
//
//        fetchRequest.predicate = NSPredicate(format: "status = %@", statusTask)
//
//
////        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "task_name", ascending: true)]
//
//        do {
//
//            let result = try manageContext.fetch(fetchRequest)
//            for data in result as! [NSManagedObject] {
//
//                if searching {
//
//                    filteredData.append(TaskModel(taskName: data.value(forKey: "task_name") as! String, estimateDuration: data.value(forKey: "estimate_duration") as! Int, status: data.value(forKey: "status") as! String))
//                } else {
//
//                    taskCollection.append(TaskModel(taskName: data.value(forKey: "task_name") as! String, estimateDuration: data.value(forKey: "estimate_duration") as! Int, status: data.value(forKey: "status") as! String))
//                }
//            }
//        } catch let error as NSError {
//
//            print("Error due to : \(error.localizedDescription)")
//        }
//    }
//
//    // function delete task
//    func deleteData(taskName: String, statusTask: String) {
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let manageContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
//        fetchRequest.predicate = NSPredicate(format: "task_name = %@", taskName)
//
//        do {
//
//            let objectFrom = try manageContext.fetch(fetchRequest)
//
//            let objectToDelete = objectFrom[0] as! NSManagedObject
//            manageContext.delete(objectToDelete)
//
//            do {
//
//                try manageContext.save()
//            } catch {
//
//                print(error)
//            }
//        } catch let error as NSError {
//
//            print("Error due to : \(error.localizedDescription)")
//        }
//
//        retrieveData(statusTask: statusSegment)
//        taskTableView.reloadData()
//    }
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if searching {

            return filteredData.count
        } else {
             if statusSegment == "DONE"{
                return taskCollectionDone.count
             } else {
                return taskCollectionPending.count
             }
        }
        
    }

    // function show list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let taskCell = tableView.dequeueReusableCell(withIdentifier: "taskCellIdentifier", for: indexPath) as! TaskCell
        
        taskCell.layer.cornerRadius = 10
        taskCell.layer.borderWidth = 5
        taskCell.layer.borderColor = #colorLiteral(red: 0.9359967113, green: 0.9867416024, blue: 0.9907793403, alpha: 1)
        taskCell.contentView.layer.cornerRadius = 10
        
//        taskCell.taskTitleLabel.text = filteredData[indexPath.row].taskName
//        taskCell.taskDurationLabel.text = "\(filteredData[indexPath.row].estimateDuration) min"
        
        if searching {

            taskCell.taskTitleLabel.text = filteredData[indexPath.row].taskName
            taskCell.taskDurationLabel.text = "\(filteredData[indexPath.row].estimateDuration) min"
        } else {
            if statusSegment == "DONE"{
                
                taskCell.taskTitleLabel.text = taskCollectionDone[indexPath.row].taskName
                taskCell.taskDurationLabel.text = "\(taskCollectionDone[indexPath.row].estimateDuration) min"
            } else {
                
                taskCell.taskTitleLabel.text = taskCollectionPending[indexPath.row].taskName
                taskCell.taskDurationLabel.text = "\(taskCollectionPending[indexPath.row].estimateDuration) min"
            }

        }
        return taskCell
    }

    // function delete task
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    // Component Delete action
        let delete = UIContextualAction(style: .destructive, title: "", handler: { (action, view, onComplete) in
            
            self.taskCollectionPending.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        delete.image = UIImage.init(named: "trash")
    
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        // Component Delete action
//        let delete = UIContextualAction(style: .destructive, title: "") { [weak self] (action, view, completionHandler) in
//            self?.deleteData(taskName: self!.filteredData[indexPath.row].taskName)
//            completionHandler(true)
//        }
//
//        delete.image = UIImage.init(named: "trash")
//
//        let configuration = UISwipeActionsConfiguration(actions: [delete])
//        return configuration
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedIndex = indexPath.row
//        taskName = taskCollection[indexPath.row].taskName
//        duration = taskCollection[indexPath.row].estimateDuration
////        taskName = filteredData[indexPath.row].taskName
////        duration = filteredData[indexPath.row].estimateDuration
//
//        self.performSegue(withIdentifier: "focusCountdownSegue", sender: self)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        taskName = taskCollectionPending[indexPath.row].taskName
        duration = taskCollectionPending[indexPath.row].estimateDuration

        self.performSegue(withIdentifier: "focusCountdownSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? FocusCountdownViewController {
            destinationVC.taskName = "\(taskName)"
            destinationVC.duration = duration
        }
    }
    
}

extension TaskViewController: UISearchBarDelegate {

    // MARK: SEARCH BAR CONFIG
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredData = []
        
        if statusSegment == "DONE" {
            let taskNameArr = taskCollectionDone.map{ $0.taskName }
            if searchText.isEmpty {

                filteredData = taskCollectionDone
            } else {

                searching = true
                for taskName in taskNameArr {

                    if taskName.lowercased().contains(searchText.lowercased()) {

                        filteredData.append(TaskModel(taskName: taskName, estimateDuration: 0, status: ""))
                    }
                }
            }
        } else {
            
            let taskNameArr = taskCollectionPending.map{ $0.taskName }
            if searchText.isEmpty {

                filteredData = taskCollectionPending
            } else {

                searching = true
                for taskName in taskNameArr {

                    if taskName.lowercased().contains(searchText.lowercased()) {

                        filteredData.append(TaskModel(taskName: taskName, estimateDuration: 0, status: ""))
                    }
                }
            }
        }

        taskTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
    }
}
