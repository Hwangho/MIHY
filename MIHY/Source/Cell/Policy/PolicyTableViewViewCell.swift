//
//  PolicyTableViewCell.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/24.
//

import UIKit

import SnapKit
import SkeletonView


protocol CellDelegate {
    func swipeCell(indexPath: IndexPath)
    
}

class PolicyTableViewViewCell: BaseTableViewCell {
    
    /// UI
    let titleLabel = UILabel()
    
    let contentLabel = UILabel()
    
    let shadowView = UIView()
    
    let roundView = UIView()
    
    let backView = UIView()
    
    let hiddenButtonStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 7
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    let hiddenButton = UIButton()
    
    
    /// variable
    var delegate: CellDelegate?
    
    var indexPath: IndexPath?
    
    var leadingConstraint: Constraint!
    
    var initialXPosition: CGFloat = 0.0
    
    
    /// Life Cycle
    override func setupAttributes() {
        super.setupAttributes()
        skeletonAttribute()
        
        titleLabel.font = Font.medium.scaledFont(size: .policyCellTitle)
        contentLabel.font = Font.light.scaledFont(size: .policyCellContent)
        contentLabel.numberOfLines = 2
        
        roundView.layer.masksToBounds = true
        roundView.layer.cornerRadius = 20
        roundView.backgroundColor = Color.BaseColor.background
        
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOpacity = 0.4
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 3, height: 3)
//        shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: shadowView.layer.cornerRadius).cgPath
        
        hiddenButton.backgroundColor = .orange
        hiddenButton.layer.cornerRadius = 20
        hiddenButton.titleLabel?.font = Font.medium.scaledFont(size: .policyCellTitle)
        hiddenButton.setTitle("숨기기", for: .normal)
        addGesture()
    }
    
    override func setupLayout() {
        [titleLabel, contentLabel].forEach { view in
            roundView.addSubview(view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(15)
            make.trailing.lessThanOrEqualToSuperview().inset(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(25)
        }
        
        shadowView.addSubview(roundView)
        roundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backView.addSubview(shadowView)
        shadowView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview().inset(10)
        }
        
        hiddenButtonStackView.addArrangedSubview(hiddenButton)
        
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalToSuperview()
            self.leadingConstraint = make.leading.equalTo(contentView.snp.leading).constraint
        }
        
        contentView.addSubview(hiddenButtonStackView)
        hiddenButtonStackView.snp.makeConstraints { make in
            make.leading.equalTo(backView.snp.trailing).offset(10)
            make.verticalEdges.equalTo(shadowView.snp.verticalEdges)
//            make.bottom.equalTo(backView.snp.bottom).offset(-10)
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        hiddenButtonStackView.frame.size.width = 0
        initialXPosition = 0
        contentView.alpha = 1
        leadingConstraint.update(offset: 0)
    }
    
    
    /// Custom Func
    func configure(policyData: RealmPolicySupport) {
        self.titleLabel.text = policyData.title
        self.contentLabel.text = policyData.introduce
    }
    
    func skeletonAttribute() {
        self.isSkeletonable = true
        backView.isSkeletonable = true
        shadowView.isSkeletonable = true
        roundView.isSkeletonable = true
        contentLabel.isSkeletonable = true
        titleLabel.isSkeletonable = true
        
        contentLabel.linesCornerRadius = 5
        titleLabel.linesCornerRadius = 5
    }
}


extension PolicyTableViewViewCell {
    func didSwipe() {
        delegate?.swipeCell(indexPath: indexPath!)
    }
    
    private func addGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanAction(_:)))
        backView.addGestureRecognizer(panGesture)
        hiddenButton.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
        panGesture.delegate = self
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc
    func didPanAction(_ sender: UIPanGestureRecognizer) {
        let changedX = sender.translation(in: backView).x
        initialXPosition += changedX

        let velocity = sender.velocity(in: self.contentView)
        if abs(velocity.y) > abs(velocity.x) {
            return
        }

        
            switch sender.state {

            case .ended:
                if  initialXPosition > -(contentView.frame.width/2) && initialXPosition < -(hiddenButtonStackView.bounds.width) {
                    hiddenButtonStackView.frame.size.width = 108
                    self.leadingConstraint?.update(offset: -hiddenButtonStackView.bounds.width)

                    UIView.animate(withDuration: 0.1) {
                        self.layoutIfNeeded()
                    }
                }
                else if initialXPosition <= -(contentView.frame.width/2){
                    self.leadingConstraint?.update(offset: -(self.backView.frame.size.width))
                    
                    UIView.animate(withDuration: 0.2) {
                        self.layoutIfNeeded()
                    }
                    ///해당 cell을 지우기 위한 data 전송
                    didSwipe()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.leadingConstraint?.update(offset: 0)
                        self.layoutIfNeeded()
                    }
                    
                }
                else {
                    self.leadingConstraint?.update(offset:0)
                    
                    UIView.animate(withDuration: 0.1) {
                        self.layoutIfNeeded()
                    }
                }
                
            default:
                if abs(velocity.y) < abs(velocity.x) + 30 {
                    if initialXPosition < 0 {
                        hiddenButtonStackView.frame.size.width = -(initialXPosition)
                        self.leadingConstraint.update(offset: initialXPosition)
                        
                        UIView.animate(withDuration: 0.1) {
                            self.layoutIfNeeded()
                        }
                    }
                    else {
                        initialXPosition = 0
                    }
                    sender.setTranslation(CGPoint.zero, in: self.backView)
                }
            }
        
        
    }
    
    @objc func deleteAction(_ sender: Any){
        print("숨기기 버튼 Click!")
        didSwipe()
    }
}
