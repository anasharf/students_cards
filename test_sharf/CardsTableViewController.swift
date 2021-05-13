//
//  CardsTableViewController.swift
//  test_sharf
//
//  Created by Анастасия Шарф on 09.05.2021.
//

import UIKit

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
//        let sourceVC = segue.source as! NewStudentTableViewController
//        let student = sourceVC.student
//
//
//        // редактирование или добавление новой ячейки
//
//        if let selectedIndexPath = tableView.indexPathForSelectedRow {
//            objects[selectedIndexPath.row] = student
//            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
//        } else {
//            let newIndexPath = IndexPath(row: objects.count, section: 0)
//            objects.append(student)
//            tableView.insertRows(at: [newIndexPath], with: .fade)
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editSegue" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
//        let student = Base.shared.studentsInfo[indexPath.row]
        let navigationVC = segue.destination as! NewViewController
        navigationVC.title = "Edit"
        var name = Base.shared.studentsInfo[indexPath.row].name
        var surname = Base.shared.studentsInfo[indexPath.row].surname
        var score = Base.shared.studentsInfo[indexPath.row].score

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
