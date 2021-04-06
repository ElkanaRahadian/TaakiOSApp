//
//  SummaryViewController.swift
//  TaakiOSApp
//
//  Created by Vivian Angela on 06/04/21.
//

import UIKit

class SummaryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var badgesTable: UITableView!
    @IBOutlet weak var dailyGoalTable: UITableView!
    @IBOutlet weak var statisticsCollection: UICollectionView!
    
    let badgesClass = badgesTableView()
    let dailyGoalClass = dailyGoalTableView()
    
    var totalMin = "1130"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let statisticsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "statisticsCellIdentifier", for: indexPath) as? StatisticsCollectionViewCell
        
//        statisticsCell?.statisticsImageTotalMin.image = UIImage(named: "Screen Shot 2021-04-06 at 21.19.54")
//        statisticsCell?.totalMinLabel.text = totalMin
        
        return statisticsCell!
    }
    

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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 228
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let badgesCell = tableView.dequeueReusableCell(withIdentifier: "badgesCellIdentifier", for: indexPath) as? BadgesTableViewCell
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
