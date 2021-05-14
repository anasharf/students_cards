//
//  CardsTableViewController.swift
//  test_sharf
//
//  Created by Анастасия Шарф on 09.05.2021.
//

import UIKit

//let base = [Base.shared.studentsInfo]

class CardsTableViewController: UITableViewController {

    
//
//    var objects = [
//        Student(name: "", surname: "", score: "")
//    ]
//
//
    override func viewDidLoad() {
        super.viewDidLoad()


        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.title = "List of students"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    

//    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
//        guard segue.identifier == "saveSegue" else { return }
//        let sourceVC = segue.source as! NewViewController
//        let name = sourceVC.nameTextField.text ?? ""
//        let surname = sourceVC.surnameTextField.text ?? ""
//        let score = sourceVC.scoreTextField.text ?? ""
//
//
//        // редактирование или добавление новой ячейки
//
//        if let selectedIndexPath = tableView.indexPathForSelectedRow {
//            Base.shared.updateInfo(name: name, surname: surname, score: score)
//            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
////        } else {
////            let newIndexPath = IndexPath(row: objects.count, section: 0)
////            objects.append(student)
////            tableView.insertRows(at: [newIndexPath], with: .fade)
////        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        guard segue.identifier == "editStudent" else { return }
//        let indexPath = tableView.indexPathForSelectedRow!
//        let student = objects[indexPath.row]
//        let navigationVC = segue.destination as! UINavigationController
//        let newStudentVC = navigationVC.topViewController as! NewStudentTableViewController
//        newStudentVC.student = student
//        newStudentVC.title = "Edit"

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "editSegue" {
            let destination = segue.destination as! NewViewController
            let indexPath = tableView.indexPathForSelectedRow!
            destination.title = "Edit"
            destination.tableIndex = indexPath.row
            destination.saveActionType = "Edit"
        } else if segue.identifier == "newStudentSegue" {
            let destination = segue.destination as! NewViewController
            destination.title = "Add new student"
            destination.saveActionType = "Add"
        }
//        guard segue.identifier == "editSegue" else { return }
//        guard let destination = segue.destination as? NewViewController else { return }
        
//        let indexPath = tableView.indexPathForSelectedRow!
//        let student = base[indexPath.row]
//        destination.nameTextField.text = base.
        
        
//        destination.title = "Edit"
//        destination.tableIndex = indexPath.row
//        destination.nameTextField.text = Base.shared.studentsInfo[indexPath.row].name
//        destination.surnameTextField.text = Base.shared.studentsInfo[indexPath.row].surname
//        destination.scoreTextField.text = Base.shared.studentsInfo[indexPath.row].score

    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Base.shared.studentsInfo.count
    }

    //возвращаю ячейку для таблицы, добираемся до ячейки через cell ( в сториборд уже была создана, не надо регистрировать. По идентифекатору нам доступна созданая ячейка, но ее тип - ТэйблВьюСел, надо КардсТВС. Делаем ЭЗ! и нужный класс

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        if let dCell = tableView.dequeueReusableCell(withIdentifier: "dCell"){
            cell = dCell
        } else {
            cell = UITableViewCell()
        }
        
        cell.textLabel!.text = Base.shared.studentsInfo[indexPath.row].title
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! CardsTableViewCell
//        let object = objects[indexPath.row]
//        cell.set(object: object)
//
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let studentLine = Base.shared.studentsInfo[indexPath.row]
        
        
        performSegue(withIdentifier: "editSegue", sender: nil)
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
