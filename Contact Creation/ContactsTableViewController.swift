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
    var filteredItems: [ContactEntity] = []
    var deleteBarButton: UIBarButtonItem!
    var addButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem!
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        get{
            return searchController.searchBar.text?.isEmpty ?? true
        }
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        self.title = "Mis Contactos"
        setUpBarButtonItems()
        
        // Get items from Core Data
        fetchContacts()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        self.tableView.tableFooterView = UIView()
    }
    
    func setUpBarButtonItems(){
        let deleteButton = UIButton(type: .custom)
        let trashIcon = UIImage(imageLiteralResourceName: "trash").withRenderingMode(.alwaysTemplate)
        deleteButton.setImage(trashIcon, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        
        self.deleteBarButton = UIBarButtonItem(customView: deleteButton)
        deleteBarButton.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        deleteBarButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(deleteButtonAction))
        navigationItem.rightBarButtonItems = [addButton, deleteBarButton]
    }
    
    func updateBarButtonItems(){
        if tableView.isEditing{
            navigationItem.rightBarButtonItems = [doneButton]
        }else{
            navigationItem.rightBarButtonItems = [addButton, deleteBarButton]
        }
    }
    
    func fetchContacts(){
        do{
            //saving sort contacts in self.items, this can be improved by saving the contacts sorted in the database
            self.items = ((try context.fetch(ContactEntity.fetchRequest()) as? [ContactEntity]) ?? [])
                .sorted(by: { Contact(contact: $0).fullName < Contact(contact: $1).fullName })
            if isFiltering{
                filterContentForSearchText(searchController.searchBar.text?.lowercased() ?? "")
            }
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        catch{
            
        }
    }
    
    @objc func deleteButtonAction(){
        self.tableView.isEditing = !self.tableView.isEditing
        updateBarButtonItems()
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
        if isFiltering {
            return filteredItems.count
        }else{
            return items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        cell.selectionStyle = .none
        let contact: Contact
        if isFiltering {
            contact = Contact(contact: filteredItems[indexPath.row])
        } else {
            contact = Contact(contact: items[indexPath.row])
        }
        cell.setContact(contact: contact)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact: Contact
        if isFiltering {
            contact = Contact(contact: filteredItems[indexPath.row])
        } else {
            contact = Contact(contact: items[indexPath.row])
        }
        let vc = NewContactViewController()
        vc.contact = contact
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contactToRemove: ContactEntity
            if isFiltering {
                contactToRemove = filteredItems[indexPath.row]
            } else {
                contactToRemove = items[indexPath.row]
            }
            self.context.delete(contactToRemove)
            do{
                try self.context.save()
            }catch{
                
            }
            self.fetchContacts()
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return tableView.isEditing
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //if cell not in displaying stop download of the image
        (cell as! ContactTableViewCell).photoImageView.kf.cancelDownloadTask()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredItems = items.filter { (contact: ContactEntity) -> Bool in
            let contact = Contact(contact: contact)
            return contact.fullName.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
}


extension ContactsTableViewController: NewContactDelegate{
    func saveNewContact(contact: Contact) {
        let newContact = ContactEntity(context: context)
        newContact.name = contact.name
        newContact.lastName = contact.lastname
        newContact.imageURL =  contact.imageURLString
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


extension ContactsTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let searchText = (searchBar.text ?? "").lowercased()
        filterContentForSearchText(searchText)
    }
    
}
