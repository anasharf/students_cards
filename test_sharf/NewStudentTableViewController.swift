//
//  NewStudentTableViewController.swift
//  test_sharf
//
//  Created by Анастасия Шарф on 10.05.2021.
//

import UIKit

class NewStudentTableViewController: UITableViewController, UITextFieldDelegate {
    
    var student = Student(name: "", surname: "", score: "")
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var scoreTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
                scoreTextField.delegate = self
        updateUI()
        updateSaveButtonState()
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
    
    // доступ к кнопке Save только если все поля заполнены
    private func updateSaveButtonState() {
        let nameText = nameTextField.text ?? ""
        let surenameText = surnameTextField.text ?? ""
        let scoreText = scoreTextField.text ?? ""
        
        saveButton.isEnabled = !nameText.isEmpty && !surenameText.isEmpty && !scoreText.isEmpty

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
    
    
    
    func showAlert () {
        let alert = UIAlertController(title: "Внимание!", message: "Name и Surname должны содержаться только русские/английские символы без пробелов. Score только цифры от 1 до 5", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //  обновлять интерфейс
    
    private func updateUI() {
        nameTextField.text = student.name
        surnameTextField.text = student.surname
        scoreTextField.text = student.score
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
        //        textField(nameTextField)
        
    }
    // переопределить родительский класс?? что это за супер здесь и зачем оно здесь??
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let score = scoreTextField.text ??  ""
        


        self.student = Student(name: name, surname: surname, score: score)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let name = Validator().isNameValid(nameTextField.text ?? "")
        let surname = Validator().isNameValid(surnameTextField.text ?? "")
        let score = Validator().isNumValid(scoreTextField.text ?? "")
          
        if identifier == "saveSegue" {
            if !name || !surname || !score {
                // Return false to cancel segue with identified Edit Profile
                showAlert()
                return false
            }
        }
        return true
    }
}
