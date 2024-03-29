//
//  NewViewController.swift
//  test_sharf
//
//  Created by Анастасия Шарф on 13.05.2021.
//

import UIKit

struct KeysDefaults {
    
    static let keyName = "nameKey"
    static let keySurname = "surnameKey"
    static let keyScore = "scoreKey"
    
}

class NewViewController: UIViewController, UITextFieldDelegate {
    
    var saveActionType: String = "Add"
    var tableIndex: Int = 0
    let defaults = UserDefaults.standard
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var scoreTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            scoreTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        } else {
        }
        scoreTextField.delegate = self
        updateUI()
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let score = scoreTextField.text ?? ""
        
        
        
        if Validator().isNumValid(score) && Validator().isNameValid(surname) && Validator().isNameValid(name){
            if saveActionType == "Add" {
                Base.shared.saveInfo(name: name, surname: surname, score: score)
                self.navigationController?.popViewController(animated: true)
            } else if saveActionType == "Edit" {
                Base.shared.updateInfo(name: name, surname: surname, score: score, dataIndex: tableIndex)
                self.navigationController?.popViewController(animated: true)
            }
        } else if !Validator().isNumValid(score) {
            showScoreAlert()
        } else if !Validator().isNumValid(name) || !Validator().isNumValid(surname){
            showAlert()
        }
        
        
        
    }
    
    private func updateUI() {
        if saveActionType == "Add" {
            nameTextField.text = ""
            surnameTextField.text = ""
            scoreTextField.text = ""
        } else if saveActionType == "Edit" {
            nameTextField.text = Base.shared.studentsInfo[tableIndex].name
            surnameTextField.text = Base.shared.studentsInfo[tableIndex].surname
            scoreTextField.text = Base.shared.studentsInfo[tableIndex].score
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    struct ValidationError: Error {
        var message: String
        
        init(_ message: String) {
            self.message = message
        }
    }
    
    class Validator {
        
        func isNameValid(_ value: String) -> Bool {
            let matched = matches(for: "[^A-Za-zА-Яа-я]", in: value)
            //если длина не равна 0, то в строке содержатся символы помимо русских и англ
            if matched.count != 0 {
                return false
            }else {
                return true
            }
        }
        
        func isNumValid(_ value: String) -> Bool{
            let matched = matches(for: "[^0-5]", in: value)
            if matched.count != 0 {
                return false
            }else {
                return true
            }
        }
        
        func matches(for regex: String, in text: String) -> [String] {
            do {
                let regex = try NSRegularExpression(pattern: regex)
                let results = regex.matches(in: text,
                                            range: NSRange(text.startIndex..., in: text))
                return results.map {
                    String(text[Range($0.range, in: text)!])
                }
            } catch let error {
                print("invalid regex: \(error.localizedDescription)")
                return []
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldScore = scoreTextField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldScore) else {
            return false
        }
        let substringToReplace = textFieldScore[rangeOfTextToReplace]
        let count = textFieldScore.count - substringToReplace.count + string.count
        return count <= 1
    }
    
    func showAlert () {
        let alert = UIAlertController(title: "Внимание!", message: "Name и Surname должны содержаться только русские/английские символы без пробелов.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showScoreAlert() {
        let alert = UIAlertController(title: "Внимание!", message: "В Score только цифры от 1 до 5", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
}
