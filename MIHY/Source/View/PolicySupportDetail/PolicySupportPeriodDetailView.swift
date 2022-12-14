//
//  PolicySupportPeriodDetailView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/27.
//

import UIKit

import SnapKit


protocol TapURLButtonDelegate {
    func tapActionButton()
    func tapCopy()
}

class PolicySupportPeriodDetailView: BaseView {
    
    let titleLabel = UILabel()
    
    let arrowLabel = UILabel()
    
    let contentButton = UIButton()
    
    let copyButton = UIButton()
    
    
    /// variable
    var delegate: TapURLButtonDelegate?
    
    
    
    /// Life Cycle
    override func setupAttributes() {
        super.setupAttributes()
        titleLabel.font = Font.medium.scaledFont(size: .policyCellTitle)
        
        contentButton.titleLabel?.font = Font.light.scaledFont(to: 10)
        contentButton.setTitleColor(Color.BaseColor.title, for: .normal)
        contentButton.addTarget(self, action: #selector(tapURLLink), for: .touchUpInside)
        
        copyButton.titleLabel?.font = Font.light.scaledFont(to: 7)
        copyButton.setTitleColor(Color.BaseColor.title, for: .normal)
        copyButton.backgroundColor = .lightGray
        copyButton.layer.cornerRadius = 5
        copyButton.addTarget(self, action: #selector(tapCopy), for: .touchUpInside)
    }
    
    override func setupLayout() {
        [titleLabel, arrowLabel, contentButton, copyButton].forEach { view in
            addSubview(view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        arrowLabel.setContentHuggingPriority(.init(rawValue: 800), for: .horizontal)
        arrowLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(titleLabel.snp.leading)
            
        }
        
        contentButton.snp.makeConstraints { make in
            make.centerY.equalTo(arrowLabel.snp.centerY)
            make.leading.equalTo(arrowLabel.snp.trailing).offset(5)
            make.bottom.lessThanOrEqualToSuperview().inset(40)
        }
        
        copyButton.snp.makeConstraints { make in
            
            make.centerY.equalTo(contentButton.snp.centerY)
            make.leading.equalTo(contentButton.snp.trailing).offset(5)
            make.trailing.lessThanOrEqualToSuperview().inset(20)
        }

    }
    
    
    override func setData() {

    }

    @objc
    func tapURLLink() {
        delegate?.tapActionButton()
    }
    
    
    @objc
    func tapCopy() {
        delegate?.tapCopy()
    }
    
    func configure(data: PolicySupport) {
        titleLabel.text = "관련 사이트"
        copyButton.setTitle("복사하기", for: .normal)
        
        arrowLabel.text = "➜ "
        contentButton.setTitle( data.applyURL, for: .normal)
    }
}
