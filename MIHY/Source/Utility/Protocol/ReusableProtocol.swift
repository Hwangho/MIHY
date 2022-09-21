//
//  ReusableProtocol.swift
//  SeSAC2DiaryRealm
//
//  Created by 황호 on 2022/08/22.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String { get }
    
}

extension UIViewController: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

//extension UICollectionReusableView: ReusableViewProtocol {
//    static var reuseIdentifier: String {
//        return String(describing: self)
//    }
//}
