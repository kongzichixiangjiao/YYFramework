//
//  GANormalizeCacheViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/12.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
import HandyJSON

class GANormalizeCacheViewController: GANormalizeBaseViewController {

    @IBOutlet weak var t: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView.titleLable.text = "缓存"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func save(_ sender: UIButton) {
        let model = GAStorageModel()
        model.name = "1"
        model.age = 1
        model.d = 2.002
        model.numbers = 2
        
        GAStorage().ga_save(model: model, fileName: "test")
        
        let zhModel = ZHStorageModel()
        zhModel.name = "zhModel"
        zhModel.age = 10
        zhModel.d = 2.003
        zhModel.numbers = 3
        
        ZHStorage.zh.zh_save(model: zhModel)
    }
    
    @IBAction func deleteAll(_ sender: UIButton) {
        let _ = GAStorage().ga_deleteAll(fileName: "test") { (finished) in
            print(finished)
        }
        
        let _ = ZHStorage.zh.zh_deleteAll { (finished) in
            print("ZHStorage.zh.zh_deleteAll")
        }
    }
    
    @IBAction func deleteName(_ sender: Any) {
        let model = GAStorageModel()
        model.name = ""
        
        GAStorage().ga_save(model: model, fileName: "test")
        
        let zhModel = ZHStorageModel()
        zhModel.name = ""
        
        ZHStorage.zh.zh_save(model: zhModel)
    }
    
    @IBAction func addName(_ sender: Any) {
        let model = GAStorageModel()
        model.name = "addName"
        
        GAStorage().ga_save(model: model, fileName: "test")
        
        ZHStorage.zh.zh_saveName(value: "zh_saveName")
    }
    
    @IBAction func getAll(_ sender: Any) {
        print("getAll--", GAStorage().ga_getAll(fileName: "test"))
        
        print(ZHStorage.zh.zh_getAll())
//        t.text = GAStorage().ga_getAll(fileName: "test") + "\n"
        t.text = String(describing: ZHStorage.zh.zh_getAll()) + "\n"
    }
    
    @IBAction func getName(_ sender: Any) {
        print("getName", GAStorage().ga_getValue(key: "name", fileName: "test") ?? "error")
        print(ZHStorage.zh.zh_getValue(key: "name") ?? "error")
        t.text = String(describing: ZHStorage.zh.zh_getValue(key: "name")) + "\n"
    }
    
    deinit {
        print("GANormalizeCacheViewController deinit")
    }
}
