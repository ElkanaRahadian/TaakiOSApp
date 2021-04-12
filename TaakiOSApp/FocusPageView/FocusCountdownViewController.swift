import Foundation
import UIKit

class FocusCountdownViewController : UIViewController {

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var startFinishButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var timer : Timer = Timer()
    var count : Int = 0
    var timerCounting : Bool = false
    var taskName: String!
    var duration: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
//        startFinishButton.setTitleColor(UIColor.green, for: .normal)
        taskNameLabel.text = taskName
        count = duration*60
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Would you like to end this focus session?", message: "All progress in this session will be lost", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Keep Focus", style: .cancel, handler: { (_) in }))
        alert.addAction(UIAlertAction(title: "End Focus", style: .destructive, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.countdownLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startFinishButton.setTitle("Start", for: .normal)
            self.startFinishButton.setTitleColor(UIColor.green, for: .normal)
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func startFinishButton(_ sender: Any) {
        if startFinishButton.currentTitle == "Finish" {
            
            let alert = UIAlertController(title: "Finish focus session?", message: "You still have \(count/60) minute left", preferredStyle: .alert)
            timer.invalidate()
            alert.addAction(UIAlertAction(title: "Not Yet", style: .cancel, handler: { [self] (_) in
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            }))
            alert.addAction(UIAlertAction(title: "Finish Focus", style: .default, handler: { (_) in
//              self.count = 0
                self.timer.invalidate()
//              self.dismiss(animated: true, completion: nil)
            }))
                self.present(alert, animated: true, completion: nil)
        } else {
            
            startFinishButton.setTitle("Finish", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }

    @objc func timerCounter() {
        count -= 1
        let time = secondsToHoursMinutesSecond(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        countdownLabel.text = timeString
    }

    func secondsToHoursMinutesSecond(seconds : Int) -> (Int,Int, Int) {
        return (seconds / 3600, ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }

    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}
