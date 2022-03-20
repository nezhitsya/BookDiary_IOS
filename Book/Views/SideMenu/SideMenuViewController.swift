//
//  SideMenuViewController.swift
//  Book
//
//  Created by 이다영 on 2022/02/17.
//

import UIKit

class SideMenuViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet var viewModel: SideMenuViewModel!
    
    var imagePicker = UIImagePickerController()
    
    lazy private var searchTap = UITapGestureRecognizer(target: self, action: #selector(searchClicked))
    lazy private var calendarTap = UITapGestureRecognizer(target: self, action: #selector(calendarClicked))
    lazy private var nicknameTap = UITapGestureRecognizer(target: self, action: #selector(editNicknameClicked))
    lazy private var imageTap = UITapGestureRecognizer(target: self, action: #selector(editProfileImageClicked))
    
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
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(imageTap)
        return view
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let view = UILabel()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(nicknameTap)
        return view
    }()
    
    private lazy var calendarView: UIView = {
        let view = UIView()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(calendarTap)
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
        view.addGestureRecognizer(searchTap)
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
        
        viewModel.getProfile(completion: { (profile) in
            self.nicknameLabel.text = profile["nickname"] as? String
            
            let data: Data = try! Data(contentsOf: URL(string: profile["profileImage"] as! String)!)
            self.profileImage.image = UIImage(data: data)
        })
    }
    
    private func configure() {
        
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
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
            calendarView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 40),
            calendarView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 40),
            calendarView.heightAnchor.constraint(equalTo: calendarImage.heightAnchor),
            
            calendarImage.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor),
            
            calendarLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            searchView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 40),
            searchView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 40),
            searchView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 40),
            searchView.heightAnchor.constraint(equalTo: searchImage.heightAnchor),
            
            searchImage.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            
            searchLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        ])
    }
    
    @objc private func calendarClicked(_ sender: UITapGestureRecognizer) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "Calendar")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func searchClicked(_ sender: UITapGestureRecognizer) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "Search")
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func editNicknameClicked(_ sender: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "닉네임 변경", message: "닉네임을 변경해주세요.", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "닉네임"
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "저장", style: .default) { _ in
            let inputNickname = alertController.textFields![0].text
            self.viewModel.editNickname(nickname: inputNickname!)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func editProfileImageClicked(_ sender: UITapGestureRecognizer) {
        let actionSheet = UIAlertController(title: "프로필 이미지",
                                            message: "프로필 이미지 변경",
                                            preferredStyle: .actionSheet)
                
        actionSheet.addAction(UIAlertAction(title: "카메라", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }))
                
        actionSheet.addAction(UIAlertAction(title: "사진첩", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .default, handler: nil))
                
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
                
        present(actionSheet, animated: true)
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

extension SideMenuViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        setProfilePicture(imageView: self.profileImage, imageToSet: image)
        
        var imageData = Data()
        imageData = image.jpegData(compressionQuality: 0.8)!
        viewModel.editProfileImage(data: imageData)
        self.dismiss(animated: true, completion: nil)
    }
    
    internal func setProfilePicture(imageView: UIImageView, imageToSet: UIImage) {
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = imageToSet
    }
    
}
