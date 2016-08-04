//
//  String+Strikethrough.swift
//  Neemu Challenge
//
//  Created by Kayron Cabral on 04/08/16.
//  Copyright © 2016 Neemu. All rights reserved.
//

import UIKit

extension String {
    
    /*
        Strikethrough in text
     */
    
    func attributedStrikethrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
}
