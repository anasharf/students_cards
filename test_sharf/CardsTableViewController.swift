//
//  CardsTableViewController.swift
//  test_sharf
//
//  Created by Анастасия Шарф on 09.05.2021.
//

import UIKit

class CardsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.title = "List of students"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "editSegue" {
            let destination = segue.destination as! NewViewController
            destination.title = "Edit"
            destination.tableIndex = tableView.indexPathForSelectedRow!.row
            destination.saveActionType = "Edit"
        } else if segue.identifier == "newStudentSegue" {
            let destination = segue.destination as! NewViewController
            destination.title = "Add new student"
            destination.saveActionType = "Add"
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Base.shared.studentsInfo.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let studentCell = tableView.dequeueReusableCell(withIdentifier: "studentCell") as! CardsTableViewCell
        
        let item = Base.shared.studentsInfo[indexPath.row]
        studentCell.nameLabel.text = item.name
        studentCell.surnameLabel.text = item.surname
        studentCell.scoreLabel.text = item.score
        
        return studentCell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Base.shared.studentsInfo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
