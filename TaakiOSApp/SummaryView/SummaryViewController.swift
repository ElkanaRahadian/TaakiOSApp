//
//  SummaryViewController.swift
//  TaakiOSApp
//
//  Created by Vivian Angela on 06/04/21.
//

import UIKit

let badgesTitle = ["Taak Challenger", "2-Hours Focus Master", "Septuple Sublime", "Ten Triumphant", "Weekend Wonder" ]
let badgesDetail = ["First Task Completed", "Focused for 120 minutes", "Reach a 7 day streak", "Completed 10 tasks", "Achieve focus on weekend"]
let progressDetail = ["1/1", "90/120", "0/7", "3/10", "0/1"]
let badgesProgressView = [1, 0.8, 0.1, 0.3, 0]
let badgesImage = ["badge-1", "badge-2", "badge-3", "badge-4", "badge-5"]

let dailyGoalPicker = UIDatePicker()

class SummaryViewController: UIViewController {

    @IBOutlet weak var badgesTable: UITableView!
    
    @IBOutlet weak var totalMinLabel: UILabel!
    @IBOutlet weak var dailyStreakLabel: UILabel!
    
    @IBOutlet weak var dailyGoalsDetail: UITextField!
    
    
    let badgesClass = badgesTableView()
//    let dailyGoalClass = dailyGoalTableView()
//    let dailyGoalPickerClass = createDailyGoalPicker()
    let timePicker = UIDatePicker()
 
    
    var array = ["1130", "100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.badgesTable.dataSource = badgesClass
//        self.dailyGoalTable.dataSource = dailyGoalClass
        
        self.badgesTable.delegate = badgesClass
//        self.dailyGoalTable.delegate = dailyGoalClass
        
        self.badgesTable.reloadData()
//        self.dailyGoalTable.reloadData()
        
        createTimePicker()
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    func createTimePicker() {
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.datePickerMode = .countDownTimer
        dailyGoalsDetail.inputView = timePicker
        dailyGoalsDetail.inputAccessoryView = createToolbar()
    }
    
    @objc func donePressed() {
        self.dailyGoalsDetail.text = "\(Int(timePicker.countDownDuration)/60) min"
        self.view.endEditing(true)
    }
    
//    extension UIView {
//        @IBInspectable var cornerRadius: CGFloat {
//            get {
//                return layer.cornerRadius
//            } set {
//                layer.cornerRadius = 5
//                layer.masksToBounds = true
//            }
//        }
//        totalMinView.layer.cornerRadius = 5
//        totalMinView.layer.masksToBounds = true
//        dailyStreakView.layer.cornerRadius = 5
//        dailyStreakView.layer.masksToBounds = true
//    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch (indexPath.row) {
//        case 0:
//            self.array
//        case 1:
//            self.
//        default:
//            break
//        }
//    }

    //untuk masukin 2 table view di satu view controller
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == self.tableView {
//           let badgesCell = tableView.dequeueReusableCell(withIdentifier: "badgesCellIdentifier", for: indexPath) as? BadgesTableViewCell
//            return badgesCell!
//        } else {
//           let dailyGoalCell = tableView.dequeueReusableCell(withIdentifier: "dailyGoalIdentifier", for: indexPath) as? DailyGoalsCell
//            return dailyGoalCell!
//        }
//        return UITableViewCell()
        
        
//        let badgesCell = UITableViewCell(frame: tableView.dequeueReusableCell(withIdentifier: "badgesCellIdentifier", for: indexPath) as? BadgesTableViewCell)
//
//        let dailyGoalCell = UITableViewCell(frame: tableView.dequeueReusableCell(withIdentifier: "dailyGoalIdentifier", for: indexPath) as! DailyGoalsCell)
//
//        return UITableViewCell(actions: [badgesCell, dailyGoalCell])
//    }


}

class badgesTableView : NSObject, UITableViewDataSource, UITableViewDelegate {
    
//    let badgesCellSpacingHeight: CGFloat = 10
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 113
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return badgesCellSpacingHeight
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return badgesCellSpacingHeight
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let badgesCell = tableView.dequeueReusableCell(withIdentifier: "badgesCellIdentifier", for: indexPath) as? BadgesTableViewCell
        
        badgesCell?.badgesTitleLabel.text = badgesTitle[indexPath.row]
        badgesCell?.badgesDetailLabel.text = badgesDetail[indexPath.row]
        badgesCell?.badgesProgressDetail.text = progressDetail[indexPath.row]
        badgesCell?.badgesProgressView.progress = Float(badgesProgressView[indexPath.row])
        badgesCell?.badgesImage.image = UIImage(named: badgesImage[indexPath.row])
       
        badgesCell?.badgesProgressView.transform.scaledBy(x: 10, y: 20) //gk berfungsi
        badgesCell?.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9843137255, blue: 0.9882352941, alpha: 1)
        badgesCell?.layer.borderWidth = 5
        badgesCell?.layer.cornerRadius = 20
        badgesCell?.clipsToBounds = true
//        badgesCell?.badgesImage.frame = CGRect(x: badgesCell!.frame, y: 10, width: 10, height: 113)
        
//        let progressView = UIProgressView(progressViewStyle: .default)
//        progressView.frame = CGRect(x: 230, y: 20, width: 130, height: 130)
//        progressView.progress += 0.5
//        progressView.rightAnchor.accessibilityActivate()
//        progressView.setProgress(Float(), animated: true)
        
//        badgesCell?.badgesProgressView.frame = CGRect(x: 10, y: 10, width: 120, height: 50)     
        
        return badgesCell!
    }
}
    
//class dailyGoalTableView : NSObject, UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let dailyGoalCell = tableView.dequeueReusableCell(withIdentifier: "dailyGoalIdentifier", for: indexPath) as? DailyGoalsCell
//
//        func createDailyGoalPicker() {
//            //create toolbar
//            let toolbar = UIToolbar()
//            toolbar.sizeToFit()
//
//            //bar button
//            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
//            toolbar.setItems([doneButton], animated: true)
//            //assign toolbar
//            dailyGoalCell?.dailyGoalDetail.inputAccessoryView = toolbar
//
//            //assign picker to text field
//            dailyGoalCell?.dailyGoalDetail.inputView = dailyGoalPicker
//        }
//
//        return dailyGoalCell!
//    }
//}

//override func prepare() {
//    super.prepare()
//
//    guard let collectionView = collectionView else { return }
//    let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
//    let maxNumColums = Int(availableWidth / minColumnWidth)
//    let cellWidth = (availableWidth / CGFloat(maxNumColums)).rounded(.down)
//
//    self.itemSize = CGSize(width: cellWidth, height: cellHeight)
//    self.sectionInset= UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
//    self.sectionInsetReference = .fromSafeArea
//}
