//
//  SummaryViewController.swift
//  TaakiOSApp
//
//  Created by Vivian Angela on 06/04/21.
//

import UIKit

let badgesTitle = ["Taak Challenger", "Triplet Challenger", "Wild Fire", "Sage", "Weekend Warrior" ]
let badgesDetail = ["First Task Completed", "3 Days Streak", "First Daily Goals Completed", "Gain 120 points", "Completed a task on Saturday and Sunday"]
let progressDetail = ["0/1", "0/3", "0/1", "0/120", "0/2"]

class SummaryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var badgesTable: UITableView!
    @IBOutlet weak var dailyGoalTable: UITableView!
    @IBOutlet weak var statisticsCollection: UICollectionView!
    
    let badgesClass = badgesTableView()
    let dailyGoalClass = dailyGoalTableView()
    
 
    
    var array = ["1130", "100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statisticsCollection.dataSource = self
        statisticsCollection.delegate = self
        
//        badgesTable.delegate = self
//        badgesTable.dataSource = self

        self.badgesTable.dataSource = badgesClass
        self.dailyGoalTable.dataSource = dailyGoalClass
        
        self.badgesTable.delegate = badgesClass
        self.dailyGoalTable.delegate = dailyGoalClass
        
        self.badgesTable.reloadData()
        self.dailyGoalTable.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let totalMinCell = collectionView.dequeueReusableCell(withReuseIdentifier: "totalMinCellIdentifier", for: indexPath) as? StatisticsCollectionViewCell
            else {
                fatalError("ERROR")
            }
            totalMinCell.totalMinLabel.text = "1130"
            return totalMinCell
        } else {
            guard let dailyStreakCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyStreakCellIdentifier", for: indexPath) as? StatisticsCollectionViewCell
            else {
                fatalError("ERROR")
            }
            return dailyStreakCell
        }
        
   
        
//        statisticsCell?.statisticsImageTotalMin.image = UIImage(named: "Screen Shot 2021-04-06 at 21.19.54")
//        statisticsCell?.totalMinLabel.text = self.array[indexPath.row]
//        statisticsCell?.backgroundColor = UIColor.cyan
//        statisticsCell?.layer.borderWidth = 155
//        statisticsCell?.layer.cornerRadius = 8
    }
    
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
        badgesCell?.badgesProgressView.transform.scaledBy(x: 10, y: 20) //gk berfungsi
        badgesCell?.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9843137255, blue: 0.9882352941, alpha: 1)
        badgesCell?.layer.borderWidth = 5
        badgesCell?.layer.cornerRadius = 10
        badgesCell?.clipsToBounds = true
//        badgesCell?.badgesImage.frame = CGRect(x: badgesCell!.frame, y: 10, width: 10, height: 113)
        
        return badgesCell!
    }
}
    
class dailyGoalTableView : NSObject, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dailyGoalCell = tableView.dequeueReusableCell(withIdentifier: "dailyGoalIdentifier", for: indexPath) as? DailyGoalsCell
        return dailyGoalCell!
    }
}

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
