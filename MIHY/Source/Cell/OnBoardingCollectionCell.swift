//
//  OnBoardingCollectionCell.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/20.
//

import UIKit

import SnapKit


class OnBoardingCollectionCell: BaseCollectionViewCell {
    
    override var isSelected: Bool{
        didSet {
            self.backgroundColor = isSelected ? Color.BaseColor.thickOrange : Color.BaseColor.background
        }
    }
    
    let titleLabel = UILabel()
    
    
    /// Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }
    
    override func setupAttributes() {
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    override func setupLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    /// Custom Func
    func configure(title: String) {
        titleLabel.text = title
    }
    
    func adjustCellSize(title: String) -> CGSize {
        self.titleLabel.text = title
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height:35)
        return self.contentView.systemLayoutSizeFitting(targetSize,
                                                        withHorizontalFittingPriority:.fittingSizeLevel,
                                                        verticalFittingPriority:.required)
    }
    

}
