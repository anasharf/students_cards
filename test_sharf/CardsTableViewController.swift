//
//  CardsTableViewController.swift
//  test_sharf
//
//  Created by Анастасия Шарф on 09.05.2021.
//

import UIKit

class CardsTableViewController: UITableViewController, UITextFieldDelegate  {
    
    var objects = [
        Student(name: "Ana", surname: "Sharf", score: "5"),
        Student(name: "Basil", surname: "Haas", score: "4"),
        Student(name: "Elizaveta", surname: "Queen", score: "2")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.title = "List of students"
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! NewStudentTableViewController
        let student = sourceVC.student
        
        
        // редактирование или добавление новой ячейки
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = student
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            objects.append(student)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editStudent" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let student = objects[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let newStudentVC = navigationVC.topViewController as! NewStudentTableViewController
        newStudentVC.student = student
        newStudentVC.title = "Edit"
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    //возвращаю ячейку для таблицы, добираемся до ячейки через cell ( в сториборд уже была создана, не надо регистрировать. По идентифекатору нам доступна созданая ячейка, но ее тип - ТэйблВьюСел, надо КардсТВС. Делаем ЭЗ! и нужный класс
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! CardsTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
