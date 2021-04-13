//
//  FinishedFocusViewController.swift
//  TaakiOSApp
//
//  Created by Apriliani Putri Prasetyo on 13/04/21.
//

import UIKit

class FinishedFocusViewController: UIViewController {

    var taskName = ""
    var duration = 0
    var status = "DONE"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.performSegue(withIdentifier: "showListDone", sender: self)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? TaskViewController {
            destinationVC.statusSegment = "DONE"
            destinationVC.taskCollectionDone.append(TaskModel(taskName: taskName, estimateDuration: duration, status: status))
        }
    }

}
