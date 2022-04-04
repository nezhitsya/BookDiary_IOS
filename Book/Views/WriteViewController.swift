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
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var descTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var start1: UIImageView!
    @IBOutlet var start2: UIImageView!
    @IBOutlet var start3: UIImageView!
    
    var yearData: Int = 0
    var monthData: Int = 0
    var dayData: Int = 0
    var titleData: String = ""
    var imageData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.yearData = UserDefaults.standard.value(forKey: "year") as! Int
        self.monthData = UserDefaults.standard.value(forKey: "month") as! Int
        self.dayData = UserDefaults.standard.value(forKey: "day") as! Int
        
        NotificationCenter.default.addObserver(self, selector: #selector(booknotificationReceived(_:)), name: .bookInfo, object: nil)
    }
    
    @objc func booknotificationReceived(_ notification: Notification) {
        guard let notificationUserInfo = notification.userInfo as? [String: String] else { return }
        
        TextConverter.loadText(text: notificationUserInfo["title"]!) { bookTitle in
            self.titleLabel.attributedText = bookTitle
            self.titleLabel.font = .boldSystemFont(ofSize: 25)
            self.titleLabel.textAlignment = .center
            self.titleLabel.adjustsFontSizeToFitWidth = true
        }
        
        let data: Data = try! Data(contentsOf: URL(string: notificationUserInfo["image"]!)!)
        self.coverImage.image = UIImage(data: data)
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
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
