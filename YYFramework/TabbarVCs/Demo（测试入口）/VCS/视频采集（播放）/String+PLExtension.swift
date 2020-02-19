//
//  String+PLExtension.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/6.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

let kPLVideoSaveFileName = "PLVideoName"
let kPLVideo_test_yydh = "123"

extension String {
    
    func pl_getFilePath(reservationNumber: String) -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let item = "/" + reservationNumber + "/" + self
        let path = (paths.first ?? "") + "/" + kPLVideoSaveFileName + item
        let url = URL(fileURLWithPath: path)
        return url
    }
}
