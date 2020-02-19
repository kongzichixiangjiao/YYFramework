//
//  GACodableViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/1.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GACodableViewController: GANavViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "Codable")
        
        let json = """
                {
                    "name"  : "Durian",
                    "gender": "male",
                    "age"   : 12,
                    "weight": 56.4,
                    "is_registed": true
                    "score" : "null"
                }
                """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            //json转Model
            let student =  try decoder.decode(Student.self, from: json)
            print(student)
            do {
                //model转JSON
                let json =  try encoder.encode(student)
                print(String(data: json, encoding: .utf8)!)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
}


enum Gender: String, Codable {
    case male = "male"
    case female = "female"
}

struct Student: Codable {
    var name       : String
    var gender     : Gender
    var age        : Int
    var weight     : Float
    var isRegisted : Bool
    var score      : Double?
    
    enum CodingKeys: String, CodingKey {
        case gender
        case name
        case age
        case score
        case weight
        case isRegisted = "is_registed"
    }
}
