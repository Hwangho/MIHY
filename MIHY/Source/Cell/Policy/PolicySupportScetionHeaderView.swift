//
//  PolicySupportScetionHeaderView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/26.
//

import UIKit

import SnapKit


class PolicySupportScetionHeaderView: BaseView {
    
    let titleLabel = UILabel()
    
    let hiddenPolicyButton = UIButton()
    
    
    override func setupAttributes() {
        titleLabel.text = "정책"
        titleLabel.font = Font.medium.scaledFont(size: .policyheaderTitlte)
        titleLabel.textColor = Color.BaseColor.title
        
        hiddenPolicyButton.setTitle("숨김정책", for: .normal)
        hiddenPolicyButton.titleLabel?.font = Font.light.scaledFont(size: .policyheaderhidden)
        hiddenPolicyButton.setTitleColor(Color.BaseColor.title, for: .normal)
    }
    
    override func setupLayout() {
        [titleLabel, hiddenPolicyButton].forEach { view in
            addSubview(view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        hiddenPolicyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
}
