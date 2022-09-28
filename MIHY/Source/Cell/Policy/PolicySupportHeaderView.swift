//
//  PolicySupportHeaderView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/26.
//

import UIKit

import SnapKit


class PolicySupportHeaderView: BaseView {
    
    let label = UILabel()
    
    
    override func setupLayout() {
        
        label.text = "야호"
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(130)
            make.centerX.equalToSuperview()
        }
    }
}
