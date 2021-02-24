//
//  ContactsTableViewController.swift
//  Contact Creation
//
//  Created by Hiroshi Melendez on 2/24/21.
//

import UIKit
import CoreData

class ContactsTableViewController: UITableViewController {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items: [ContactEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        self.title = "Mis Contactos"
        setUpBarButtonItems()
        
        // Get items from Core Data
        fetchContacts()
    }
    
    func setUpBarButtonItems(){
        let deleteButton = UIButton(type: .custom)
        let trashIcon = UIImage(imageLiteralResourceName: "trash").withRenderingMode(.alwaysTemplate)
        deleteButton.setImage(trashIcon, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        
        let deleteBarButton = UIBarButtonItem(customView: deleteButton)
        deleteBarButton.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        deleteBarButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
        navigationItem.rightBarButtonItems = [addButton, deleteBarButton]
    }
    
    func fetchContacts(){
        do{
            self.items = (try context.fetch(ContactEntity.fetchRequest()) as? [ContactEntity]) ?? []
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        catch{
            
        }
    }
    
    @objc func deleteButtonAction(){
        self.tableView.isEditing = !self.tableView.isEditing
  }
    
    @objc func addButtonAction(){
        let vc = NewContactViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        let contact = Contact(contact: items[indexPath.row])
        cell.setContact(contact: contact)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contactToRemove = self.items[indexPath.row]
            self.context.delete(contactToRemove)
            do{
                try self.context.save()
            }catch{
                
            }
            
            self.fetchContacts()
         }
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        (cell as! ContactTableViewCell).photoImageView.kf.cancelDownloadTask()
    }
    
}


extension ContactsTableViewController: NewContactDelegate{
    func saveNewContact(contact: Contact) {
        let newContact = ContactEntity(context: context)
        newContact.name = contact.name
        newContact.lastName = contact.lastname
        newContact.imageURL =  contact.imageURL
        newContact.phoneNumber = contact.phoneNumber
        //Save Data
        do{
            try self.context.save()
        }catch{
            print("guay")
        }
        
        self.fetchContacts()
    }
    
    
}
