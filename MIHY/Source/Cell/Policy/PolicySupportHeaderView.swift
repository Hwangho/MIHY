//
//  PolicySupportHeaderView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/26.
//

import UIKit

import SnapKit


class PolicySupportHeaderView: BaseView {
    
    
    let nameLabel = UILabel()
    
    lazy var centerRoundView = headerRoundView(multiplied: centerCirclemultiplied, type: .center)
    
    lazy var leftRoundView = headerRoundView(multiplied: sideCirclemultiplied, type: .left)
    
    lazy var rightRoundView = headerRoundView(multiplied: sideCirclemultiplied, type: .right)
    
    let centerCirclemultiplied: Float = 0.4
    
    let sideCirclemultiplied: Float = 0.3
    
    
    
    override func setupAttributes() {
        super.setupAttributes()
        backgroundColor = Color.BaseColor.lightOrange
        
        centerRoundView.backgroundColor = Color.BaseColor.thickOrange
        leftRoundView.backgroundColor = Color.BaseColor.middleOrange
        rightRoundView.backgroundColor = Color.BaseColor.middleOrange
    }
    
    override func setupLayout() {
        
        let cendterCircleradius = UIScreen.main.bounds.width * CGFloat(centerCirclemultiplied)/2
        let sideCircleradius = UIScreen.main.bounds.width * CGFloat(sideCirclemultiplied)/2
        
        
        [leftRoundView, rightRoundView, centerRoundView].forEach { view in
            addSubview(view)
        }
        
        centerRoundView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(50)
            make.width.height.equalTo(self.snp.width).multipliedBy(centerCirclemultiplied)
        }
        
        leftRoundView.snp.makeConstraints { make in
            make.top.equalTo(centerRoundView.snp.centerY).offset(-(cendterCircleradius/4))
            make.trailing.equalTo(centerRoundView.snp.centerX).offset(-(sideCircleradius*2/3))
            make.width.height.equalTo(self.snp.width).multipliedBy(sideCirclemultiplied)
        }
        
        rightRoundView.snp.makeConstraints { make in
            make.top.equalTo(centerRoundView.snp.centerY).offset(-(cendterCircleradius/4))
            make.leading.equalTo(centerRoundView.snp.centerX).offset(sideCircleradius*2/3)
            make.width.height.equalTo(self.snp.width).multipliedBy(sideCirclemultiplied)
        }
    }
    
}
