//
//  Font.swift
//  MemoNote
//
//  Created by 송황호 on 2022/09/01.
//

import Foundation
import UIKit


enum Font {
        
    case bold
    case light
    case medium
    
    var type: String {
        switch self {
        case .bold: return "esamanruOTFBold"
        case .light: return "esamanruOTFLight"
        case .medium: return "esamanruOTFMedium"
        }
    }
    
    func scaledFont(to size: CGFloat) -> UIFont {
        return UIFont(name: self.type, size: size)!
    }
    
    func scaledFont(size: FontTextSize) -> UIFont {
        return UIFont(name: self.type, size: size.value)!
    }
}


enum FontTextSize {
    case navigationTitle
    case onBoardingtitle
    case onBoardingSectionTitle
    case onBoardingCellTitle
    case policySectionTitle
    case policyheaderTitlte
    case policyheaderhidden
    case policyCellTitle
    case policyCellContent
    case cellContent
    case changeMemoText
    
    var value: CGFloat {
        switch self {
        case .navigationTitle: return 18
            
        case .onBoardingtitle: return 18
        case .onBoardingSectionTitle: return 16
        case .onBoardingCellTitle: return 14
            
        case .policySectionTitle: return 23
        case .policyheaderTitlte: return 16
        case .policyheaderhidden: return 14
        case .policyCellTitle: return 16
        case .policyCellContent: return 12
        case .cellContent: return 12
        case .changeMemoText: return 15
        }
    }
}
