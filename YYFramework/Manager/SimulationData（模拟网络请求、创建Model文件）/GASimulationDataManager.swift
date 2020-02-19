//
//  GALocalTestDataManager.swift
//  YYFramework
//
//  Created by houjianan on 2019/3/11.
//  Copyright © 2019 houjianan. All rights reserved.
//  模拟网络请求、创建Model文件

import Foundation

open class GASimulationDataManager {
    static let share = GASimulationDataManager()
    
    var resultData: [String : String] = [String : String]()
    
    public func ga_getLocalData(fileName: String, macName: String = "houjianan", localFileName: String = "ll", className: String = "Test", preString: String = "GA", isOptional: Bool = true, inheritClass: String = "") -> [String : Any] {
        guard let pathLocal = Bundle.main.path(forResource: fileName, ofType: "") else {
            #if DEBUG
            print("fileName 错误")
            #endif
            return ["":""]
        }
        
        let d = try! Data(contentsOf: URL(fileURLWithPath: pathLocal))
        let dic = try? JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers)
        writeToFile(macName: macName, localFileName: localFileName, dic: dic as! [String : Any], className: className, preString: preString, isOptional: isOptional, inheritClass: inheritClass)
        return dic as! [String : Any]
    }
    
    public func ga_simulationRequest(fileName: String, macName: String, localFileName: String = "ll", className: String = "Test", preString: String = "GA", isOptional: Bool = true, inheritClass: String, returnCode: Int = 200, isError: Bool = false, errorMessage: String = "模拟错误请求-完成", deadline: Double = 2.0, resultHandler: @escaping (_ data: [String : Any]) -> (), errorHandler: @escaping (_ error: String) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + deadline) {
            if isError {
                DispatchQueue.main.async {
                    errorHandler(errorMessage)
                }
            } else {
                DispatchQueue.main.async {
                    var dic = self.ga_getLocalData(fileName: fileName, macName: macName, localFileName: localFileName, className: className, preString: preString, isOptional: isOptional, inheritClass: inheritClass)
                    if var result = dic["result"] as? [String : Any] {
                        if let _ = result["isNextPage"], let data = result["data"] as? [Any] {
                            result["isNextPage"] = Date().minute / 2 == 0 ? true : false
                            let count = data.count
                            var newData = [Any]()
                            let randomCount = Int(arc4random()) % (count - 1)
                            while newData.count < 10 && count != 0 {
                                newData.append(data[randomCount])
                            }
                            result["data"] = newData
                            dic["result"] = result
                        }
                    }
                    
                    if returnCode != 200 {
                        dic["returnCode"] = returnCode
                    }
                    
                    if isError {
                        errorHandler(errorMessage)
                        return
                    }
                    
                    #if DEBUG
                    print(dic)
                    #endif
                    resultHandler(dic)
                }
            }
        }
    }
    
    func _splitData(dicData: [String : Any], className: String, preString: String, key: String, isOptional: Bool = true, inheritClass: String) {
        var resultString = ""
        
        for (k, v) in dicData {
            // "<#GA"+""+"#"+">"
            if let dic = v as? [String : Any] {
                let newKey = key + _firstWordsBig(s: k)
                resultString += "    var " + k + ": " + preString + className + newKey + "Model" + "?\n"
                _splitData(dicData: dic, className: className, preString: preString, key: newKey, isOptional: isOptional, inheritClass: inheritClass)
            } else if let arr = v as? [Any] {
                let newKey = key + _firstWordsBig(s: k)
                resultString += "    var " + k + ": " + "[" + preString + className + newKey + "Model" + "]?\n"
                _splitData(arrData: arr, className: className, preString: preString, key: newKey, isOptional: isOptional, inheritClass: inheritClass)
            } else if let _ = v as? String {
                if isOptional {
                    resultString += "    var " + _newClassName(className: k) + ": " + "String?\n"
                } else {
                    resultString += "    var " + _newClassName(className: k) + ": " + "String = \"\"\n"
                }
            } else if let _ = v as? Int {
                if isOptional {
                    resultString += "    var " + _newClassName(className: k) + ": " + "Int?\n"
                } else {
                    resultString += "    var " + _newClassName(className: k) + ": " + "Int = 0\n"
                }
            } else {
                
            }
        }
        
        resultData[className + _firstWordsBig(s: key)] = resultString + (inheritClass == "HandyJSON" ? "\n    required init() {}\n": "")
    }
    
    func _splitData(arrData: [Any], className: String, preString: String, key: String, isOptional: Bool = true, inheritClass: String) {
        for item in [arrData.first] {
            if let d = item as? [String : Any] {
                _splitData(dicData: d, className: className, preString: preString, key: key, isOptional: isOptional, inheritClass: inheritClass)
            } else if let arr = item as? [Any] {
                _splitData(arrData: arr, className: className, preString: preString, key: key, isOptional: isOptional, inheritClass: inheritClass)
            } else {
                #if DEBUG
                print("_splitData error")
                #endif
            }
        }
    }
    
    public func writeToFile(macName: String = "houjianan", localFileName: String = "ll", dic: [String : Any], className: String, preString: String = "GA", isOptional: Bool = true, inheritClass: String) {
        resultData.removeAll()
        
        _splitData(dicData: dic, className: className, preString: preString, key: "", isOptional: isOptional, inheritClass: inheritClass)
        
        let path = "/Users/" + macName + "/Desktop/" + localFileName + "/" + className + ".swift"
        
        if FileManager.default.createFile(atPath: path, contents: nil, attributes: nil) {
            let fileHandle = FileHandle.init(forWritingAtPath: path)
            let headerData = ("//\n//  \(className).swift\n//  \(Bundle.main.infoDictionary! ["CFBundleName"] as! String)\n//\n//  Created by " + macName + " on \(Date())\n//  Copyright © 2019 " + macName + ". All rights reserved.\n\n").data(using: String.Encoding.utf8)
            fileHandle?.write(headerData!)
            var bodyString = (inheritClass == "HandyJSON" ? "import HandyJSON \n\n" : "")
            for (k, v) in resultData {
                if v.isEmpty {
                    continue
                }
                let newK = (_firstWordsBig(s: k).contains(className) ? "" : className) + _firstWordsBig(s: k)
                let classTitle = _firstWordsBig(s: newK + (_firstWordsBig(s: newK).contains("Model") ? "" : "Model")) + (inheritClass.isEmpty ? "" : ": \(inheritClass)")
                bodyString += "class " + preString + classTitle + " {\n"
                bodyString += v + ""
                bodyString += "}\n\n"
            }
            
            let bodyData = bodyString.data(using: String.Encoding.utf8)
            fileHandle?.write(bodyData!)
        }
    }
    
    private func _firstWordsBig(s: String) -> String {
        return s.prefix(1).uppercased() + s.sd_sliceString(start: 1, end: s.length)
    }
    
    private func _newClassName(className: String) -> String {
        let set = CharacterSet.init(charactersIn: "[ _`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：\"”“’。，、？]|\n|\r|\t")
        var newClassName = className.trimmingCharacters(in: set)
        if newClassName == "id" {
            newClassName = newClassName.uppercased()
        }
        let words = newClassName.components(separatedBy: "_")
        if words.count > 1 {
            var item = ""
            for i in 0..<words.count {
                if i == 0 {
                    item += words[i]
                } else {
                    item += words[i].prefix(1).uppercased() + words[i].sd_sliceString(start: 1, end: words[i].length)
                }
            }
            newClassName = item
        }
        return newClassName
    }
    
}

extension String {
    
    func sd_sliceString(start: Int, end: Int) -> String {
        if self.isEmpty {
            return self
        }
        return sd_sliceString((start...end))
    }
    
    func sd_subString(range: Range<String.Index>) -> String {
        if self.isEmpty {
            return self
        }
        return String(self[range.lowerBound..<range.upperBound])
    }
    
    // 切割字符串(区间范围 (区间范围 前闭后开) )
    func sd_sliceString(_ range:CountableRange<Int>) -> String{
        guard
            let startIndex = sd_validStartIndex(original: range.lowerBound),
            let endIndex = sd_validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        
        return String(self[startIndex..<endIndex])
    }
    
    // 切割字符串(区间范围 (区间范围 前闭后闭) )
    func sd_sliceString(_ range:CountableClosedRange<Int>) -> String {
        guard
            let start_Index = sd_validStartIndex(original: range.lowerBound),
            let end_Index = sd_validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        if(endIndex.utf16Offset(in: self) <= end_Index.utf16Offset(in: self)) {
            return String(self[start_Index..<endIndex])
        }
        return String(self[start_Index...end_Index])
    }
    
    // 校验字符串位置是否合理
    func sd_validIndex(original: Int) -> String.Index {
        switch original {
        case ...startIndex.utf16Offset(in: self):
            return startIndex
        case endIndex.utf16Offset(in: self)...:
            return endIndex
        default:
            return index(startIndex, offsetBy: original)
        }
    }
    
    // 校验是否是合法的起始位置
    func sd_validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.utf16Offset(in: self) else { return nil }
        return sd_validIndex(original:original)
    }
    
    // 校验是否是合法的结束位置
    func sd_validEndIndex(original: Int) -> String.Index? {
//        guard original >= startIndex.encodedOffset else { return nil }
        guard original >= startIndex.utf16Offset(in: self) else { return nil }
        return sd_validIndex(original:original)
    }
    
}
