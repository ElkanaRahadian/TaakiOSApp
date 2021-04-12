import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskSearchBar: UISearchBar!
    @IBOutlet weak var taskTableView: UITableView!
    
    @IBAction func statusSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            statusSegment = "DONE"
        default:
            statusSegment = "PENDING"
        }
        taskTableView.reloadData()
    }

    var duration = 0
    var filteredData = [TaskModel]()
    var searching = false
    var selectedIndex = 0
    var statusSegment: String = "PENDING"
    var taskCollectionPending: [TaskModel] = [TaskModel(taskName: "Hi-Fi Prototype", estimateDuration: 120, status: "PENDING"), TaskModel(taskName: "Final Project", estimateDuration: 150, status: "PENDING")]
    var taskCollectionDone: [TaskModel] = [TaskModel(taskName: "Lo-Fi Prototype", estimateDuration: 60, status: "DONE"), TaskModel(taskName: "Self Learning", estimateDuration: 60, status: "DONE"), TaskModel(taskName: "Keynote Presentation", estimateDuration: 30, status: "DONE")]
    var taskName = ""
    
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

    // function show list task
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
            print("Delete task: \(self.taskCollectionPending[indexPath.row].taskName)")
        })
        
        delete.image = UIImage.init(named: "trash")
    
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
    // function select task
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if statusSegment == "PENDING" {
            
            selectedIndex = indexPath.row
            taskName = taskCollectionPending[indexPath.row].taskName
            duration = taskCollectionPending[indexPath.row].estimateDuration
            
            print("Select task: \(taskName)")
            self.performSegue(withIdentifier: "focusCountdownSegue", sender: self)
        }
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
            if searchText == "" {

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
            if searchText == "" {

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
