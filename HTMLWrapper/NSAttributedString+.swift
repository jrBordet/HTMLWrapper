//
//  NSAttributedString+.swift
//  HTMLWrapTutorial
//
//  Created by Jean Raphael on 07/02/2018.
//  Copyright © 2018 Jean Raphael Bordet. All rights reserved.
//

import UIKit

extension NSAttributedString {
    static func wrapString(_ body: String, wrapperName: String) -> NSAttributedString? {
        do {
            if let wrapperPath = Bundle.main.path(forResource: wrapperName, ofType: "html") {
                do {
                    if let resultWrappedData = String(data: try Data(contentsOf: URL(fileURLWithPath: wrapperPath)), encoding: .utf8)?.replacingOccurrences(of: "$BODY", with: body) {
                        if let resultWrappedData = resultWrappedData.data(using: String.Encoding.unicode, allowLossyConversion: true) {
                            return  try NSAttributedString(data: resultWrappedData,
                                                           options: [.documentType: NSAttributedString.DocumentType.html,
                                                                     .characterEncoding: String.Encoding.utf8.rawValue],
                                                           documentAttributes: nil)
                        }
                    }
                } catch {
                    fatalError(error.localizedDescription)                    
                }
            }
            
            return nil
        }
    }
}
