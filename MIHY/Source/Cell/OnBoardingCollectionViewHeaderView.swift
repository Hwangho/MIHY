//
//  OnBoardingCollectionViewHeaderView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/21.
//

import UIKit


class OnBoardingCollectionViewHeaderView: UICollectionReusableView {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
