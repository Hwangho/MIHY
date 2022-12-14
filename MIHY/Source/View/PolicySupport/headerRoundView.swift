//
//  headerRoundView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/29.
//

import UIKit

import SnapKit
import RealmSwift


class headerRoundView: BaseView {
    
    enum type {
        case center
        case left
        case right
        
        var title: String {
            switch self {
            case .center: return "맞춤 정책"
            case .left: return "NEW"
            case .right: return "숨김"
            }
        }
        
        var titleFont: UIFont {
            switch self {
            case .center: return Font.bold.scaledFont(to: 15)
            case .left, .right: return Font.bold.scaledFont(to: 12)
            }
        }
        
        var contentFont: UIFont {
            switch self {
            case .center: return Font.bold.scaledFont(to: 24)
            case .left, .right: return Font.bold.scaledFont(to: 25)
            }
        }
    }
    
    
    /// UI
    let stackView = UIStackView()
    
    let titleLabel = UILabel()
    
    let contentLabel = UILabel()
    
    let realmRepository = RealmService.shared
    
    var count: Observable<Int> = Observable(0)
    
    
    /// Variable
    let Multiplied: Float
    
    let roundType: headerRoundView.type

    
    /// Initialization
    init(multiplied: Float, type: headerRoundView.type) {
        self.Multiplied = multiplied
        self.roundType = type
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Life Cycle
    override func setupAttributes() {
        super.setupAttributes()
        layer.cornerRadius = (UIScreen.main.bounds.width * CGFloat(Multiplied)) / 2
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        
        titleLabel.text = roundType.title
        titleLabel.font = roundType.titleFont
        titleLabel.textAlignment = .center
        
        contentLabel.font = roundType.contentFont
        contentLabel.textAlignment = .center
    }
    
    override func setupLayout() {
        [titleLabel, contentLabel].forEach { view in
            stackView.addArrangedSubview(view)
        }
        
        addSubview(stackView)
        switch roundType {
            
        case .center:
            stackView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        case .left:
            stackView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview().offset(-3)
            }
        case .right:
            stackView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview().offset(3)
            }
        }
    }
    
    override func setData() {
        realmRepository.featchData()
    }
    
    override func setBinding() {
        let totalCount = UserDefaults.standard.integer(forKey: "totalCount")
        switch roundType {
        case .center: self.count.value = totalCount - realmRepository.PolicySupportData.filter{ $0.isHidden == true }.count  // total - 숨김 정책
        case .left: self.count.value = totalCount - realmRepository.PolicySupportData.filter{ $0.newPolicy == false }.count  // 새로운 정책
        case .right: self.count.value = realmRepository.PolicySupportData.filter{ $0.isHidden == true }.count
            
        }
        
        count.bind { [weak self] count in
            self?.contentLabel.text = String(count)
        }
    }
}

