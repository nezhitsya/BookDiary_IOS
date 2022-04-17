//
//  MyDiaryViewController.swift
//  Book
//
//  Created by 이다영 on 2022/04/09.
//

import UIKit

class MyDiaryViewController: UIViewController {
    
    @IBOutlet var viewModel: CalendarViewModel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MyDiaryTableViewCell", bundle: nil), forCellReuseIdentifier: "DiaryList")
        
        viewModel.loadingStarted = { [weak self] in
        }
        
        viewModel.loadingEnded = { [weak self] in
        }
        
        viewModel.diaryListUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.list()
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

extension MyDiaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.diaryCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DiaryList", for: indexPath) as! MyDiaryTableViewCell
        let diaries = viewModel.diaries(at: indexPath.row)

        cell.setDiary(diaries)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteDiary(at: indexPath.row)
            viewModel.list()
        }
    }
    
}
