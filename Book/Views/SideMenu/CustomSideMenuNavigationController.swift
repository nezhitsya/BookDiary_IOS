//
//  SideMenuViewController.swift
//  Book
//
//  Created by 이다영 on 2022/02/17.
//

import UIKit
import SideMenu

class CustomSideMenuNavigationController: SideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presentationStyle = .menuSlideIn
        self.leftSide = true
        self.statusBarEndAlpha = 0.0
        self.menuWidth = self.view.frame.width * 0.7
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
