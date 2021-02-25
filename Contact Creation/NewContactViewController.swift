//
//  NewContactViewController.swift
//  Contact Creation
//
//  Created by Hiroshi Melendez on 2/24/21.
//

import UIKit

class NewContactViewController: UIViewController {
    
    var delegate: NewContactDelegate?
    var imageURL: String = ""
    var contact: Contact?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = view.bounds
        return view
    }()
    
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
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
        textField.keyboardType = .numberPad
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
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        addSubViews()
        setupLayout()
        dismissKeyboardGesture()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        if let contact = self.contact{
            nameTextField.text = contact.name
            lastNameTextField.text = contact.lastname
            photoImageView.kf.setImage(with: contact.imageURL)
            phoneNumberTextField.text = contact.phoneNumber
            self.title = contact.fullName
            addPhotoButton.isHidden = true
            nameTextField.isUserInteractionEnabled = false
            lastNameTextField.isUserInteractionEnabled = false
            phoneNumberTextField.isUserInteractionEnabled = false
            saveButton.isHidden = true
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    func addSubViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(headerView)
        headerView.addSubview(photoImageView)
        headerView.addSubview(addPhotoButton)
        
        firstView.addSubview(nameTitleLabel)
        firstView.addSubview(nameTextField)
        secondView.addSubview(lastNameTitleLabel)
        secondView.addSubview(lastNameTextField)
        thirdView.addSubview(phoneNumberTitleLabel)
        thirdView.addSubview(phoneNumberTextField)
        
        stackView.addArrangedSubview(firstView)
        stackView.addArrangedSubview(secondView)
        stackView.addArrangedSubview(thirdView)
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(saveButton)
    }
    
    func setUpBarButtonItems(){
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonAction))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func setupLayout(){
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        photoImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 32).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        addPhotoButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        addPhotoButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 12).isActive = true
        addPhotoButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -32).isActive = true
        addPhotoButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 80*3).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
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
    
    @objc func saveButtonAction(){
        let contact = Contact(name: nameTextField.text ?? "",
                              lastname: lastNameTextField.text ?? "",
                              phoneNumber: phoneNumberTextField.text ?? "",
                              imageURL: imageURL)
        if let delegate =  self.delegate{
            delegate.saveNewContact(contact: contact)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func addPhotoButtonAction(){
        let vc = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.photosCollectionViewControllerDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    
}


extension NewContactViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = textField.text! + string
        let regEx: String
        if textField.keyboardType == .numberPad{
            regEx = "[0-9]{0,12}"
        }else{
            regEx = "[A-Za-z]{0,32}"
        }
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: newString)
    }
}

extension NewContactViewController: PhotosCollectionViewControllerDelegate{
    
    func imagePicked(imageURL: String) {
        self.imageURL = imageURL
        let url = URL(string: imageURL)
        photoImageView.kf.setImage(with: url)
    }
    
}
