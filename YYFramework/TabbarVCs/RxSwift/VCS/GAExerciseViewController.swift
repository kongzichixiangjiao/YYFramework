//
//  GAExerciseViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/10/20.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GAExerciseViewController: GANavViewController {
    
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "练习")
        
        _bindLabel()
    }
    
    private func _bindLabel() {
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        observable
            .map { "当前索引数：\($0 )"}
            .bind { [weak self](text) in
                //收到发出的索引数后显示到label上
                self?.label.text = text
        }
        .disposed(by: disposeBag)
    }
    
}
