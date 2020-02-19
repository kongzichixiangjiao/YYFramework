//
//  GAThemes.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/21.
//  Copyright © 2019年 houjianan. All rights reserved.
//


import Foundation
import SwiftTheme
import SSZipArchive

let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
let libraryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]

enum GAThemes: Int {
    
    case red   = 0
    case yello = 1
    case blue  = 2
    case night = 3
    
    // MARK: -
    
    static var current = GAThemes.red
    static var before  = GAThemes.red
    
    // MARK: - Switch Theme
    
    static func switchTo(_ theme: GAThemes) {
        before  = current
        current = theme
        
        switch theme {
        case .red   : ThemeManager.setTheme(plistName: "Red", path: .mainBundle)
        case .yello : ThemeManager.setTheme(plistName: "Yellow", path: .mainBundle)
        case .blue  : ThemeManager.setTheme(plistName: "Blue", path: .sandbox(blueDiretory))
        case .night : ThemeManager.setTheme(plistName: "Night", path: .mainBundle)
        }
    }
    
    static func switchToNext() {
        var next = current.rawValue + 1
        var max  = 2 // without Blue and Night
        
        if isBlueThemeExist() { max += 1 }
        if next >= max { next = 0 }
        
        switchTo(GAThemes(rawValue: next)!)
    }
    
    // MARK: - Switch Night
    
    static func switchNight(_ isToNight: Bool) {
        switchTo(isToNight ? .night : before)
    }
    
    static func isNight() -> Bool {
        return current == .night
    }
    
    // MARK: - Download
    
    static func downloadBlueTask(_ handler: @escaping (_ isSuccess: Bool) -> Void) {
        
        let session = URLSession.shared
        let url = "https://github.com/jiecao-fm/SwiftThemeResources/blob/master/20170128/Blue.zip?raw=true"
        let URL = Foundation.URL(string: url)
        
        let task = session.downloadTask(with: URL!, completionHandler: { location, response, error in
            
            guard let location = location , error == nil else {
                DispatchQueue.main.async {
                    handler(false)
                }
                return
            }
            
            let manager = FileManager.default
            let zipPath = cachesURL.appendingPathComponent("Blue.zip")
            
            _ = try? manager.removeItem(at: zipPath)
            _ = try? manager.moveItem(at: location, to: zipPath)
            
            let isSuccess = SSZipArchive.unzipFile(atPath: zipPath.path,
                                                   toDestination: unzipPath.path)
            
            DispatchQueue.main.async {
                handler(isSuccess)
            }
        })
        
        task.resume()
    }
    
    static func isBlueThemeExist() -> Bool {
        return FileManager.default.fileExists(atPath: blueDiretory.path)
    }
    
    static let blueDiretory : URL = unzipPath.appendingPathComponent("Blue/")
    static let unzipPath    : URL = libraryURL.appendingPathComponent("Themes/20170128")
    
}
