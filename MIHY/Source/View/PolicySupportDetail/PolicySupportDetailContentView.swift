//
//  PolicySupportDetailContentView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/27.
//

import UIKit

import SnapKit

class PolicySupportDetailContentView: BaseView {
    
    /// UI
    let titleLabel = UILabel()
    
    let introduceLabel = UILabel()
    
    let titleLineView = UIView()
    
    
    /// variable
    private let data: RealmPolicyData?
    
    
    /// Initialization
    init(data: RealmPolicyData?) {
        self.data = data
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Life Cycle
    override func setupAttributes() {
        titleLabel.font = Font.bold.scaledFont(to: 20)
        titleLabel.numberOfLines = 0
        
        introduceLabel.font = Font.light.scaledFont(size: .cellContent)
        introduceLabel.numberOfLines = 0
        
        titleLineView.backgroundColor = Color.BaseColor.middleOrange
    }
    
    override func setupLayout() {
        [titleLabel, titleLineView, introduceLabel].forEach { view in
            addSubview(view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(20)
            make.trailing.lessThanOrEqualToSuperview().inset(20)
        }
        
        titleLineView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.trailing.equalTo(titleLabel.snp.trailing).offset(10)
            make.height.equalTo(2)
        }
        
        introduceLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleLineView.snp.bottom).offset(30)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    override func setData() {
        titleLabel.text = data?.title
        introduceLabel.text = data?.introduce
    }
    
}
