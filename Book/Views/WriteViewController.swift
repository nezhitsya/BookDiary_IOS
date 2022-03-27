//
//  WriteViewController.swift
//  Book
//
//  Created by 이다영 on 2022/02/27.
//

import UIKit

class WriteViewController: UIViewController {
    
    @IBOutlet var viewModel: WriteViewModel!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var descTextView: UITextView!
    var yearData: Int = 0
    var monthData: Int = 0
    var dayData: Int = 0
    var titleData: String = ""
    var imageData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: .date, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(booknotificationReceived(_:)), name: .bookInfo, object: nil)
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        guard let notificationUserInfo = notification.userInfo as? [String: Int] else { return }
        
        self.yearData = notificationUserInfo["year"]!
        self.monthData = notificationUserInfo["month"]!
        self.dayData = notificationUserInfo["day"]!
    }
    
    @objc func booknotificationReceived(_ notification: Notification) {
        guard let notificationUserInfo = notification.userInfo as? [String: String] else { return }
        
        self.titleData = notificationUserInfo["title"]!
        self.imageData = notificationUserInfo["image"]!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveClicked(_ sender: UIButton) {
//        self.viewModel.write(title: <#T##String#>, image: <#T##String#>, desc: <#T##String#>, year: <#T##Int#>, month: <#T##Int#>, day: <#T##Int#>)
    }

}
