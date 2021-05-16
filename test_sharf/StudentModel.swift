//
//  StudentModel.swift
//  test_sharf
//
//  Created by Анастасия Шарф on 09.05.2021.
//

import Foundation



class Base {
    
    static let shared = Base()
    
    let defaults = UserDefaults.standard
    struct Student:Codable {
        var name: String
        var surname: String
        var score: String
        var title: String {
            return "\(name), \(surname), \(score)"
        }
        
    }
    
    var studentsInfo:[Student] {
        
        get {
            if let data = defaults.value(forKey: "studentsInfo") as? Data{
                return try! PropertyListDecoder().decode([Student].self , from: data)
            } else {
                return [Student]()
            }
        }
        
        set{
            if let data = try? PropertyListEncoder().encode(newValue){
                defaults.set(data, forKey: "studentsInfo")
            }
        }
    }
    
    func saveInfo(name:String, surname:String, score:String){
        let info = Student(name: name, surname: surname, score: score)
        studentsInfo.insert(info, at: 0)
        print("OBJ = \(name) \(surname) \(score)")
    }
    
    func updateInfo(name: String, surname: String, score: String, dataIndex: Int){
        guard let data = defaults.data(forKey: "studentsInfo") else { return }
        
        defaults.dictionaryRepresentation()
        
        guard var obj = try? PropertyListDecoder().decode([Student].self, from: data) else { return }
        
        print(obj)
        obj[dataIndex].name = name
        obj[dataIndex].surname = surname
        obj[dataIndex].score = score
        guard let newData = try? PropertyListEncoder().encode(obj) else { return }
        
        defaults.set(newData, forKey: "studentsInfo")
        
    }
    
}




