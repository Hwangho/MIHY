//
//  Color.swift
//  SeSAC2DiaryRealm
//
//  Created by 황호 on 2022/08/21.
//
 
import UIKit


struct Color {
        
    struct BaseColor {
        static let background = UIColor { change(traitCollection: $0).backgroundColor }     // UIColor(dynamicProvider: <#T##(UITraitCollection) -> UIColor#>)
        static let thickOrange = UIColor { change(traitCollection: $0).thickOrangeColor }
        static let middleOrange = UIColor { change(traitCollection: $0).OrangeColor }
        static let lightOrange = UIColor { change(traitCollection: $0).lightOrangeColor }
        static let title = UIColor { change(traitCollection: $0).textColor }
        static let content = UIColor { change(traitCollection: $0).contentColor }
        static let highlight = UIColor { change(traitCollection: $0).highlightColor }
        
        
        // Theme 변환기
        static private func change(traitCollection: UITraitCollection) -> Theme {
            guard let theme = Theme(rawValue: traitCollection.userInterfaceStyle.rawValue) else { return .light }
            return theme
        }
    }
    
}
