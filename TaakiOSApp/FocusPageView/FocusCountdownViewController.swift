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
        startFinishButton.setTitleColor(UIColor.green, for: .normal)
        taskNameLabel.text = taskName
        count = duration*60
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Cancel Countdown", message: "Are you sure you would like to cancel the countdown ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Keep Focus", style: .cancel, handler: { (_) in }))
        alert.addAction(UIAlertAction(title: "End Focus", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.countdownLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startFinishButton.setTitle("Start", for: .normal)
            self.startFinishButton.setTitleColor(UIColor.green, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func startFinishButton(_ sender: Any) {
        if (timerCounting) {
            timerCounting = false
            timer.invalidate()
            startFinishButton.setTitle("Start", for: .normal)
            startFinishButton.setTitleColor(UIColor.green, for: .normal)
        }
        else {
            timerCounting = true
            startFinishButton.setTitle("Finish", for: .normal)
            startFinishButton.setTitleColor(UIColor.red, for: .normal)
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
