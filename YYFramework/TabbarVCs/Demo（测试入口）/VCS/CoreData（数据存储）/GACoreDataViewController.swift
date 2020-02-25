//
//  GACoreDataViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/24.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit
import CoreData
import MagicalRecord

class GACoreDataViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func add(_ sender: Any) {
//        add_coreData()
        add_mr_coreData()
    }
    
    func add_mr_coreData() {
        let model = GATestModel.mr_createEntity()
        model?.name = "lsm"
        do {
            try NSManagedObjectContext.mr_default().save()
        } catch {
            
        }
    }
    
    func add_coreData() {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.managedObjectContext
        //        步骤二：建立一个entity
        let entity = NSEntityDescription.entity(forEntityName: "GATestModel", in: managedObectContext)
        let model = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        //        步骤三：保存文本框中的值到person
        model.setValue("hjn", forKey: "name")
        //        步骤四：保存entity到托管对象中。如果保存失败，进行处理
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("无法保存")
        }
        //        步骤五：保存到数组中，更新UI
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        let models = GATestModel.mr_findAll() ?? []
        for model in models {
            model.mr_deleteEntity()
        }
        do {
            try NSManagedObjectContext.mr_default().save()
        } catch {
            
        }
    }
    
    @IBAction func change(_ sender: Any) {
        let models = GATestModel.mr_findAll() ?? []
        for model in models {
            (model as! GATestModel).name = "lsm_changed"
        }
        do {
            try NSManagedObjectContext.mr_default().save()
        } catch {
            
        }
    }
    
    @IBAction func look(_ sender: Any) {
//        look_coreData()
        look_mr_coreData()
    }
    
    func look_mr_coreData() {
        let models = GATestModel.mr_findAll() ?? []
        for model in models {
            print("mr-", (model as! GATestModel).name)
        }
    }
    
    func look_coreData() {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.managedObjectContext
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GATestModel")
        //        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                for reuslt in results {
                    let model = reuslt as! GATestModel
                    print(model.name)
                }
            }
        } catch  {
            fatalError("获取失败")
        }
    }
}
