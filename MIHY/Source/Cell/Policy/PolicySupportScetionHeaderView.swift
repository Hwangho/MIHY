//
//  PolicySupportScetionHeaderView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/26.
//

import UIKit

import SnapKit

protocol TapActionDelegate {
    func tapActionButton()
}

class PolicySupportScetionHeaderFooterView: BaseView {
    
    enum sectionType {
        case header(SectionPolicySupport.type)
        case footer
    }
    
    
    /// UI
    let titleLabel = UILabel()
    
    let newImage = UIImageView()
    
    let hiddenPolicyButton = UIButton()
    
    
    /// Variable
    var delegate: TapActionDelegate?
    
    let type: sectionType
    
    init(type: sectionType) {
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setupAttributes() {
        titleLabel.font = Font.medium.scaledFont(size: .policyheaderTitlte)
        titleLabel.textColor = Color.BaseColor.title
        
        newImage.image = UIImage(named: "new")
        
        hiddenPolicyButton.setTitle("숨김정책", for: .normal)
        hiddenPolicyButton.titleLabel?.font = Font.light.scaledFont(size: .policyheaderhidden)
        hiddenPolicyButton.setTitleColor(Color.BaseColor.title, for: .normal)
        hiddenPolicyButton.addTarget(self, action: #selector(tapHiddenPolicyButton), for: .touchUpInside)
        
        switch type {
        case .header(let value):
            hiddenPolicyButton.isHidden = true
            switch value {
            case .newPolicy:
                newImage.isHidden = false
            default:
                newImage.isHidden = true
            }
            
        case .footer:
            titleLabel.isHidden = true
            newImage.isHidden = true
        }
    }
    
    override func setupLayout() {
        [titleLabel, newImage, hiddenPolicyButton].forEach { view in
            addSubview(view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            make.top.equalTo(15)
        }
        
        newImage.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(-3)
            make.bottom.equalTo(titleLabel.snp.top).offset(8)
            make.width.height.equalTo(20)
        }
        
        hiddenPolicyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(5)
            make.bottom.equalToSuperview().inset(-5)
        }
    }
    
    @objc
    func tapHiddenPolicyButton() {
        delegate?.tapActionButton()
    }
}
