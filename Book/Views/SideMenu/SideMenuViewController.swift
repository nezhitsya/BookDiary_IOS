//
//  SideMenuViewController.swift
//  Book
//
//  Created by 이다영 on 2022/02/17.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImage)
        view.addSubview(nicknameLabel)
        view.addSubview(calendarView)
        view.addSubview(searchView)
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let view = UILabel()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "닉네임"
        return view
    }()
    
    private lazy var calendarView: UIView = {
        let view = UIView()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarImage)
        view.addSubview(calendarLabel)
        return view
    }()
    
    private lazy var calendarImage: UIImageView = {
        let view = UIImageView()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "today")
        return view
    }()
    
    private lazy var calendarLabel: UILabel = {
        let view = UILabel()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "캘린더"
        view.textColor = .black
        return view
    }()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchImage)
        view.addSubview(searchLabel)
        return view
    }()
    
    private lazy var searchImage: UIImageView = {
        let view = UIImageView()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "search")
        return view
    }()
    
    private lazy var searchLabel: UILabel = {
        let view = UILabel()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "책 검색"
        view.textColor = .black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
        self.profileImage.image = UIImage(named: "profile")
    }
    
    private func configure() {
        
        view.addSubview(mainView)
        
        let layouts = [
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            profileImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            profileImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 150),
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            
            nicknameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            nicknameLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),

            calendarView.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 60),
            calendarView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 40),
            calendarView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 40),
            
            calendarImage.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor),
            
            calendarLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            searchView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 60),
            searchView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 40),
            searchView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 40),
            
            searchImage.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            
            searchLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        ]
        
        layouts.forEach { $0.isActive = true }
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
