//
//  Transition+Extension.swift
//  SeSAC2DiaryRealm
//
//  Created by 황호 on 2022/08/21.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present            // 네비게이션 없이 Prsent
        case presentNavigation  // 네비게이션 임베드 Prsent
        case presentFullNavigation  // 네비게이션 풀스크린
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .presentFullNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .overFullScreen
            self.present(navi, animated: true)
        
        }
    }
    
}
