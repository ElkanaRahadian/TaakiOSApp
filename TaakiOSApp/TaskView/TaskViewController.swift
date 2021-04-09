//
//  TaskViewController.swift
//  TaakiOSApp
//
//  Created by Apriliani Putri Prasetyo on 05/04/21.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    @IBAction func taskSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            status = "DONE"
        default:
            status = "PENDING"
        }
    }
    
    @IBOutlet weak var taskSearchBar: UISearchBar!
    @IBOutlet weak var taskTableView: UITableView!
    
    var taskCollection = [TaskModel]()
    var status: String!
    
    var filteredData = [TaskModel]()
    var searching = false
    
    var taskArray = ["Lo-Fi Prototype", "Hi-Fi Prototype", "Self Learning", "Skripsi", "Ujian Kalkulus"]
    var durationArray = [60, 120, 60, 150, 120]
    var statusArray = ["DONE", "PENDING", "DONE", "PENDING", "DONE"]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        taskTableView.backgroundColor = #colorLiteral(red: 0.9359967113, green: 0.9867416024, blue: 0.9907793403, alpha: 1)
        taskTableView.backgroundView?.layer.cornerRadius = 10
        taskTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        taskSearchBar.delegate = self
        taskSearchBar.backgroundImage = UIImage()
        
        setUpInitialDataToCoreData()

    }
    
    func setUpInitialDataToCoreData() {
        if taskCollection.count == 0 {
            createData()
        }
        
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
            task.setValue(statusArray[i-1], forKey: "status")
        }
    }
    
    // function retrieve data
    func retrieveData() {
        
        taskCollection.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
                
        
//        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "task_name", ascending: true)]
        
        do {
            
            let result = try manageContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                
                if searching {
                    
                    filteredData.append(TaskModel(taskName: data.value(forKey: "task_name") as! String, estimateDuration: data.value(forKey: "estimate_duration") as! Int))
                } else {
                    
                    taskCollection.append(TaskModel(taskName: data.value(forKey: "task_name") as! String, estimateDuration: data.value(forKey: "estimate_duration") as! Int))
                }
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if searching {
            
            return filteredData.count
        } else {
            
            return taskCollection.count
        }
        
    }

    // function show list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let taskCell = tableView.dequeueReusableCell(withIdentifier: "taskCellIdentifier", for: indexPath) as! TaskCell

        taskCell.layer.cornerRadius = 10
        taskCell.layer.borderWidth = 5
        taskCell.layer.borderColor = #colorLiteral(red: 0.9359967113, green: 0.9867416024, blue: 0.9907793403, alpha: 1)
        taskCell.contentView.layer.cornerRadius = 10
        
        if searching {
            
            taskCell.taskTitleLabel.text = filteredData[indexPath.row].taskName
            taskCell.taskDurationLabel.text = "\(filteredData[indexPath.row].estimateDuration) min"
        } else {
            
            taskCell.taskTitleLabel.text = taskCollection[indexPath.row].taskName
            taskCell.taskDurationLabel.text = "\(taskCollection[indexPath.row].estimateDuration) min"
        }
        return taskCell
    }

    // function delete task
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // Component Delete action
        let delete = UIContextualAction(style: .destructive, title: "") { [weak self] (action, view, completionHandler) in
            self?.deleteData(taskName: self!.filteredData[indexPath.row].taskName)
            completionHandler(true)
        }

        delete.image = UIImage.init(named: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
}

extension TaskViewController: UISearchBarDelegate {

    // MARK: SEARCH BAR CONFIG
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredData = []

        if searchText.isEmpty {

            filteredData = taskCollection
        } else {

            searching = true
            for taskName in taskArray {

                if taskName.lowercased().contains(searchText.lowercased()) {
                    
                    filteredData.append(TaskModel(taskName: taskName))
                }
            }
        }

        taskTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
    }
}
