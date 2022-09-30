//
//  PolicySupportDetailApllyQulificationView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/27.
//

import UIKit

import SnapKit


class PolicySupportDetailApllyQulificationView: BaseView {
    
    let titleLabel = UILabel()
    
    let stackView = UIStackView()
    
    let ageQulificationView = ApllyQulificationView()
    
    let educationQulificationView = ApllyQulificationView()
    
    let majorQulificationView = ApllyQulificationView()
    
    let employmentQulificationView = ApllyQulificationView()
    
    let specialQulificationView = ApllyQulificationView()
    
    
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
        
        titleLabel.text = "신청 자격"
        titleLabel.font = Font.medium.scaledFont(size: .policyCellTitle)
        
        stackView.axis = .vertical
        stackView.spacing = 10
    }
    
    override func setupLayout() {
        
        [ageQulificationView, educationQulificationView, majorQulificationView, employmentQulificationView, specialQulificationView].forEach { view in
            stackView.addArrangedSubview(view)
        }
        
        [titleLabel, stackView].forEach { view in
            addSubview(view)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.lessThanOrEqualToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        
    }
    
    override func setData() {
        
        ageQulificationView.titleLabel.text = "· 연령:"
        ageQulificationView.contentLabel.text = data?.age
        
        educationQulificationView.titleLabel.text = "· 학력:"
        educationQulificationView.contentLabel.text = data?.education
        
        majorQulificationView.titleLabel.text = "· 전공:"
        majorQulificationView.contentLabel.text = data?.major
        
        employmentQulificationView.titleLabel.text = "· 취업 상태:"
        employmentQulificationView.contentLabel.text = data?.employment
        
        specialQulificationView.titleLabel.text = "· 특화분야:"
        specialQulificationView.contentLabel.text = data?.specialization
    }
    
    
    // MARK: - ApllyQulificationView
    
    class ApllyQulificationView: BaseView {
        
        let stackView = UIStackView()
        
        let titleLabel = UILabel()
        
        let contentLabel = UILabel()
        
        override func setupAttributes() {
            super.setupAttributes()
            
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fill
            
            stackView.spacing = 15
            
            titleLabel.font = Font.medium.scaledFont(to: 14)
            
            contentLabel.font = Font.light.scaledFont(size: .cellContent)
            contentLabel.numberOfLines = 0
        }
        
        override func setupLayout() {
            
            titleLabel.setContentHuggingPriority(.required, for: .horizontal)
            titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

            [titleLabel, contentLabel].forEach { view in
                stackView.addArrangedSubview(view)
            }
            
            addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
        }
    }

}
