//
//  ContactsTableViewController.swift
//  Contact Creation
//
//  Created by Hiroshi Melendez on 2/24/21.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        self.title = "Mis Contactos"
        setUpBarButtonItems()
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
    
    @objc func deleteButtonAction(){
        print("foooo")
    }
    
    @objc func addButtonAction(){
        let vc = NewContactViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        let contact = Contact(name: "Juan", lastname: "Pikachu", phoneNumber: "809-123-1234", photoURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(indexPath.row%150 + 1).png"))
        cell.setContact(contact: contact)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! ContactTableViewCell).photoImageView.kf.cancelDownloadTask()
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
