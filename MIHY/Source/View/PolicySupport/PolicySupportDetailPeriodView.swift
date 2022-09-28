//
//  PolicySupportDetailPeriodView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/27.
//

import UIKit

import SnapKit


class PolicySupportDetailPeriodView: BaseView {
    
    let titleLabel = UILabel()
    
    let backRoundView = UIView()
    
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
    
    
    override func setupAttributes() {
        super.setupAttributes()
        
        titleLabel.text = "신청 기간"
        titleLabel.font = Font.medium.scaledFont(size: .policyCellTitle)
        
        backRoundView.layer.cornerRadius = 15
        backRoundView.backgroundColor = Color.BaseColor.lightOrange
        
        contentLabel.font = Font.light.scaledFont(size: .cellContent)
        contentLabel.textAlignment = .center
        
    }
    
    override func setupLayout() {
        
        backRoundView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        [titleLabel, backRoundView].forEach { view in
            addSubview(view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        backRoundView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            
        }
    }
    
    override func setData() {
        contentLabel.text = data?.period
    }
    
}
