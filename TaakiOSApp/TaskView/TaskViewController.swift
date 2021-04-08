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
    
    var taskCollection = [TaskModel]()
    
    var filteredData = [TaskModel]()
    
    var taskArray = ["Lo-Fi Prototype", "Hi-Fi Prototype", "Self Learning", "Skripsi"]
    var durationArray = [60, 120, 60, 150]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        taskSearchBar.delegate = self
        
        setUpInitialDataToCoreData()

    }
    
    func setUpInitialDataToCoreData() {
//        if taskCollection.count == 0 {
//            createData()
//        }
        
        retrieveData()
        taskTableView.reloadData()
        
    }
    
    // function create data
    func createData() {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        guard let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: manageContext) else { return }
        
        for i in 1...taskArray.count {
            let task = NSManagedObject(entity: taskEntity, insertInto: manageContext)
            task.setValue(durationArray[i-1], forKey: "estimate_duration")
            task.setValue(taskArray[i-1], forKey: "task_name")
        }
    }
    
    // function retrieve data
    func retrieveData() {
        
        filteredData.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "task_name", ascending: true)]
        
        do {
            let result = try manageContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                filteredData.append(TaskModel(taskName: data.value(forKey: "task_name") as! String, estimateDuration: data.value(forKey: "estimate_duration") as! Int))
            }
        } catch let error as NSError {
            print("Error due to : \(error.localizedDescription)")
        }
    }
    
    // function delete task
    func deleteData(taskName: String) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "task_name = %@", taskName)
        
        do {
            let objectFrom = try manageContext.fetch(fetchRequest)
            
            let objectToDelete = objectFrom[0] as! NSManagedObject
            manageContext.delete(objectToDelete)
            
            do {
                try manageContext.save()
            } catch {
                print(error)
            }

        } catch let error as NSError {
            print("Error due to : \(error.localizedDescription)")
        }
        
        retrieveData()
        taskTableView.reloadData()
    }
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return taskCollection.count
//    }
//
//    // function show list
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let taskCell = tableView.dequeueReusableCell(withIdentifier: "taskCellIdentifier", for: indexPath) as! TaskCell
//
//        taskCell.taskTitleLabel.text = taskCollection[indexPath.row].taskName
//        taskCell.taskDurationLabel.text = "\(taskCollection[indexPath.row].estimateDuration) min"
//
//        return taskCell
//    }
//
//    // function delete task
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        // Component Delete action
//        let delete = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
//            self?.deleteData(taskName: self!.taskCollection[indexPath.row].taskName)
//            completionHandler(true)
//        }
//        delete.backgroundColor = .red
//        let configuration = UISwipeActionsConfiguration(actions: [delete])
//        return configuration
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredData.count
    }

    // function show list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let taskCell = tableView.dequeueReusableCell(withIdentifier: "taskCellIdentifier", for: indexPath) as! TaskCell

        taskCell.taskTitleLabel.text = filteredData[indexPath.row].taskName
        taskCell.taskDurationLabel.text = "\(filteredData[indexPath.row].estimateDuration) min"

        return taskCell
    }

    // function delete task
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // Component Delete action
        let delete = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.deleteData(taskName: self!.filteredData[indexPath.row].taskName)
            completionHandler(true)
        }
        delete.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
}

extension TaskViewController: UISearchBarDelegate {

    // MARK: SEARCH BAR CONFIG
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredData = []

        if searchText == "" {

            filteredData = taskCollection
        } else {

            for taskName in taskArray {

                if taskName.lowercased().contains(searchText.lowercased()) {
                    
                    filteredData.append(TaskModel(taskName: taskName))
                }
            }
        }

        taskTableView.reloadData()
    }

}
