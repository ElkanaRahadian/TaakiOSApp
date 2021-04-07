//
//  FocusPageCongrats.swift
//  TaakiOSApp
//
//  Created by Devina Ranlyca on 06/04/21.
//

import UIKit

class FocusPageCongrats: UIViewController {
    @IBOutlet weak var congratsImage: UIImageView!
    
    @IBOutlet weak var congratsTitle: UILabel!
    @IBOutlet weak var congratsDesc1: UILabel!
    @IBOutlet weak var congratsDesk2: UILabel!
    
    @IBOutlet weak var congratsPoints: UILabel!
    
    @IBOutlet weak var congratsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        congratsImage.image = #imageLiteral(resourceName: <#T##String#>)
        
    }
}

