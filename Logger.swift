//
//  Logs.swift
//
//  Created by sungals07 on 2020/02/20.
//  Copyright © 2020 sungals07. All rights reserved.
//

import Foundation

enum LogType{
    
    /// Verbose 💜🗣 - A verbose message, usually useful when working on a specific problem
    case v
    
    /// Debug 💚🔍 - A debug message
    case d
    
    /// Info 💙ℹ️ - An info message
    case i
    
    /// Warning 💛⚠️ - A warning message, may indicate a possible error
    case w
    /// Error ❤️❗️ - An error occurred, but it's recoverable, just info about what happened
    case e
    
    /// Severe ❗️ - A severe error occurred, we are likely about to crash now
    case s
    
    
    var symbol : String {
        switch self {
        case .v : return "💜"
        case .d : return "💚"
        case .i : return "💙"
        case .w : return "💛"
        case .e : return "❤️"
        case .s : return "❗️"
        }
    }
    
    var capitalLetter : String{
        return "\(self)".uppercased()
    }
    
}
/// 커스텀 로그
final class Logger {
    
    //A trick to see the expected results - Put the macros as the function's default values and the values of the macro will be of the function's caller
    class func log(_ logType:LogType, _ logMessage: String, file: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        
        //Do some checkups here
        //For example:
        //        guard Config.environment == .debug else {
        //            return
        //        }
        
        //Get only the file name without the full path
        // var filename = (file as NSString).lastPathComponent
        // filename = filename.components(separatedBy: ".")[0]
        let fileName = file.split(separator: "/").last ?? ""
        let funcName = functionName.split(separator: "(").first ?? ""
        
        //Generate current date string
        let currentDate = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss.SSS"
        let dateString = df.string(from: currentDate)
        
        //Print
//        print("┌─────────────────────────────────────────────────────────────────────────")
//        print("│ \(dateString) \n│ \(filename).\(functionName) (\(lineNumber)) [\(logType.capitalLetter)] \(logType.symbol)")
//        print("└─────────────────────────────────────────────────────────────────────────")
//        print("\(logMessage)\n")
//        print("┌─────────────────────────────────────────────────────────────────────────")
        print("\(logType.symbol) \(dateString) │ [\(filename)] \(funcName) (\(lineNumber)) [\(logType.capitalLetter)]")
//        print("└─────────────────────────────────────────────────────────────────────────")
        print("\(logMessage)\n")
    }
    
    class func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcName: String = #function) {
        let th = Thread.current.isMainThread ? "main": Thread.current.name ?? "-"
        if let obj = object {
            print("***** \(Date()) \(th) \(filename.components(separatedBy: "/").last ?? "") (LINE\(line)) :: \(funcName) :: \(obj)")
            
        } else {
            print("***** \(Date()) \(th) \(filename.components(separatedBy: "/").last ?? "") (LINE\(line)) :: \(funcName) :: nil") 
        }
    }

}
