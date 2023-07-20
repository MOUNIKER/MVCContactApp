//
//  TableViewController.swift
//  MVCContactApp
//
//  Created by Narasimha on 17/07/23.
//

import UIKit

var contacts: [ContactFields] = []

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var filteredContacts: [ContactFields] = []
    var sectionTitles: [String] = []
    var sectionedContacts: [[ContactFields]] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    var model: Contact = Contact()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.reloadData()
        model.parseJSONFromFile()
        contacts.sort { $0.firstname.uppercased() < $1.firstname.uppercased() }
        filteredContacts = contacts
        generateSectionedContacts()
    }
    func generateSectionedContacts() {
        sectionTitles.removeAll()
        sectionedContacts.removeAll()
        
        for contact in filteredContacts {
            let firstLetter = String(contact.firstname.prefix(1)).uppercased()
            
            if !sectionTitles.contains(firstLetter) {
                sectionTitles.append(firstLetter)
                sectionedContacts.append([contact])
            } else {
                let index = sectionTitles.firstIndex(of: firstLetter)!
                sectionedContacts[index].append(contact)
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionedContacts[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableCell", for: indexPath) as! ContactTableCell
        let contact = sectionedContacts[indexPath.section][indexPath.row]
        cell.firstLbl.text = "\(contact.firstname) \(contact.lastname)"
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sectionTitles.firstIndex(of: title)!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        secondVc.selectedContact = sectionedContacts[indexPath.section][indexPath.row]
        navigationController?.pushViewController(secondVc, animated: true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredContacts = searchText.isEmpty ? contacts : contacts.filter({ $0.firstname.lowercased().localizedCaseInsensitiveContains(searchText)
        })
        generateSectionedContacts()
        tableView.reloadData()
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        searchBar.text = ""
        contacts.removeAll()
        viewDidLoad()
        self.tableView.reloadData()
    }
}
