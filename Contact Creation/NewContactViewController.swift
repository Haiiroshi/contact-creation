//
//  NewContactViewController.swift
//  Contact Creation
//
//  Created by Hiroshi Melendez on 2/24/21.
//

import UIKit

class NewContactViewController: UIViewController, UITextFieldDelegate {
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let addPhotoButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 12
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitle("Cargar imagen", for: .normal)
        return button
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nombre"
        return textField
    }()
    
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "Nombre"
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Apellido"
        return textField
    }()
    
    private let lastNameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "Apellido"
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Teléfono"
        return textField
    }()
    
    private let phoneNumberTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "Teléfono"
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private let firstView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let secondView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let thirdView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 12
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Guardar", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.title = "Nuevo Contacto"
        setUpBarButtonItems()
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonAction), for: .touchUpInside)
        addSubViews()
        setupLayout()
        dismissKeyboardGesture()
    }
    
    func addSubViews(){
        self.view.addSubview(headerView)
        headerView.addSubview(photoImageView)
        headerView.addSubview(addPhotoButton)
        stackView.addArrangedSubview(firstView)
        firstView.addSubview(nameTitleLabel)
        firstView.addSubview(nameTextField)
        secondView.addSubview(lastNameTitleLabel)
        secondView.addSubview(lastNameTextField)
        thirdView.addSubview(phoneNumberTitleLabel)
        thirdView.addSubview(phoneNumberTextField)
        stackView.addArrangedSubview(secondView)
        stackView.addArrangedSubview(thirdView)
        self.view.addSubview(stackView)
        self.view.addSubview(saveButton)
    }
    
    func setUpBarButtonItems(){
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonAction))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func setupLayout(){
        headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        photoImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 32).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addPhotoButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        addPhotoButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 12).isActive = true
        addPhotoButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -32).isActive = true
        addPhotoButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 80*3).isActive = true
        
        saveButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        saveButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        saveButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        setupSubView(contentView: firstView, label: nameTitleLabel, textField: nameTextField)
        setupSubView(contentView: secondView, label: lastNameTitleLabel, textField: lastNameTextField)
        setupSubView(contentView: thirdView, label: phoneNumberTitleLabel, textField: phoneNumberTextField)
    }
    
    func setupSubView(contentView: UIView, label: UILabel, textField: UITextField){
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -12).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        textField.delegate = self
        textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 12).isActive = true
        textField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        textField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    @objc func addPhotoButtonAction(){
        
    }
    
    @objc func cancelButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    func dismissKeyboardGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
