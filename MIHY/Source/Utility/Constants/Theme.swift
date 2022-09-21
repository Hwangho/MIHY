//
//  Theme.swift
//  MemoNote
//
//  Created by 송황호 on 2022/08/31.
//

import UIKit


enum Theme: Int {
    case device
    case light
    case dark
    
    
    var thickOrangeColor: UIColor {
        switch self {
        default:
            return  #colorLiteral(red: 1, green: 0.6392156863, blue: 0, alpha: 1)
        }
    }
    
    var OrangeColor: UIColor {
        switch self {
        default:
            return #colorLiteral(red: 1, green: 0.7882352941, blue: 0.3725490196, alpha: 1)
        }
    }
    
    var lightOrangeColor: UIColor {
        switch self {
        default:
            return #colorLiteral(red: 0.9960784314, green: 0.937254902, blue: 0.7764705882, alpha: 1)
        }
    }
    
    
    var backgroundColor: UIColor {
        switch self {
        case .dark:
            return UIColor.black
        default:
            return UIColor.white
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .dark:
            return UIColor.white
        default:
            return UIColor.black
        }
    }
    
    var contentColor: UIColor {
        switch self {
        default:
            return UIColor.gray
        }
    }
    
    var highlightColor: UIColor {
        switch self {
        default:
            return UIColor.orange
        }
    }
    
}
