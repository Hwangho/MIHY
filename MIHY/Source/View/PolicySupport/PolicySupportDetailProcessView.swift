//
//  PolicySupportDetailProcessView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/27.
//

import UIKit

import SnapKit


class PolicySupportDetailProcessView: BaseView {
    
    let titleLabel = UILabel()
    
    let arrowLabel = UILabel()
    
    let contentLabel = UILabel()
    
    
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
        super.setupAttributes()
    
        titleLabel.font = Font.medium.scaledFont(size: .policyCellTitle)
        contentLabel.font = Font.light.scaledFont(size: .cellContent)
        contentLabel.numberOfLines = 0
    }
    
    override func setupLayout() {
        
        [titleLabel, arrowLabel, contentLabel].forEach { view in
            addSubview(view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        arrowLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(titleLabel.snp.leading)
            
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(arrowLabel.snp.top)
            make.leading.equalTo(arrowLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            
        }
    }
    
    override func setData() {
        
        titleLabel.text = "신청 절차"
        guard let data = data else { return }
        arrowLabel.text = "➜ "
        contentLabel.text = data.process
    }
    
}
