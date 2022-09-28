//
//  OnBoardingCollectionView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/17.
//

import UIKit
import SwiftUI


class OnBoardingCollectionView: BaseView {
    
    /// UI
    let collectionView: UICollectionView = {
        let layout = TagFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    
    /// Variable
    let type: OnBoardingQuestionType
    
    lazy var viewModel = OnBoardingCollectionViewModel(type: type)
    
    var array: [PolicyType] = []
    
    
    /// Initialize
    init(type: OnBoardingQuestionType) {
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    /// Life Cycle
    override func setupAttributes() {
        super.setupAttributes()
        collectionViewdelegate()
    }
    
    override func setupLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    /// Custom Fuinction
    func collectionViewdelegate() {
        collectionView.register(OnBoardingCollectionCell.self, forCellWithReuseIdentifier: OnBoardingCollectionCell.reuseIdentifier)
        collectionView.register(OnBoardingCollectionViewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "OnBoardingCollectionViewHeaderView")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        switch type {
        case .policy, .myInfo:
            collectionView.allowsMultipleSelection = true
        default:
            break
        }
    }
    
}


// MARK: - UICollectionVIew 관련

extension OnBoardingCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch type {
        case .policy: return PolicyType.allSection.count
        case .region: return 1
        case .myInfo: return MyInfo.allSection.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch type {
        case .policy: return PolicyType.allSection[section].count
        case .region: return Region.allCases.count
        case .myInfo: return MyInfo.allSection[section].count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionCell.reuseIdentifier, for: indexPath) as? OnBoardingCollectionCell else {
            return UICollectionViewCell() }
        cell.backgroundColor = .white
        switch type {
        case .policy:
            let text = PolicyType.allSection[indexPath.section][indexPath.row].rowTitle
            cell.titleLabel.text = text
            let dataArray = viewModel.policyDatas.value.values.flatMap { $0 }
            cell.isSelected =  dataArray.contains(text)
            
        case .region:
            cell.titleLabel.text = Region.allCases[indexPath.row].title
            
        case .myInfo:
            let text = MyInfo.allSection[indexPath.section][indexPath.row].rowTitle
            cell.titleLabel.text = text
            let dataArray = viewModel.myInfoDatas.value.values.flatMap { $0 }
            cell.isSelected = dataArray.contains(text)
        default: break
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OnBoardingCollectionViewHeaderView", for: indexPath) as? OnBoardingCollectionViewHeaderView else { return UICollectionReusableView() }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            switch type {
            case .policy:
                header.titleLabel.text = PolicyType.allSection[indexPath.section][indexPath.row].sectionTitle
            case .region:
                header.titleLabel.text = "지역"
            case .myInfo:
                header.titleLabel.text = MyInfo.allSection[indexPath.section][indexPath.row].sectionTitle
            default: break
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch type {
        case .policy:
            let type = PolicyType.allSection[indexPath.section][indexPath.row].checkedData.0
            let value = PolicyType.allSection[indexPath.section][indexPath.row].checkedData.1
            viewModel.appendPolicyData(key: type, value: value)
            
        case .region:
            viewModel.updateRegion(type: Region.allCases[indexPath.row])
            
        case .myInfo:
            let type = MyInfo.allSection[indexPath.section][indexPath.row].checkedData.0
            let value = MyInfo.allSection[indexPath.section][indexPath.row].checkedData.1
            viewModel.appendmyInfoData(key: type, value: value)
            
        default:
            print("내 정보 관련 데이터 저장")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch type {
        case .policy:
            let type = PolicyType.allSection[indexPath.section][indexPath.row].checkedData.0
            let value = PolicyType.allSection[indexPath.section][indexPath.row].checkedData.1
            viewModel.deletePolicyData(key: type, value: value)

        case .myInfo:
            let type = MyInfo.allSection[indexPath.section][indexPath.row].checkedData.0
            let value = MyInfo.allSection[indexPath.section][indexPath.row].checkedData.1
            viewModel.deletemyInfoData(key: type, value: value)
        default:
            print("내 정보 관련 데이터 제거")
        }
    }

    /// cell width size dynamic 하도록
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionCell.reuseIdentifier, for: indexPath) as? OnBoardingCollectionCell else {
            return  .zero }
        
        switch type {
        case .policy:
            return cell.adjustCellSize(title: PolicyType.allSection[indexPath.section][indexPath.item].rowTitle)
        case .region:
            return cell.adjustCellSize(title: Region.allCases[indexPath.item].title)
        case .myInfo:
            return cell.adjustCellSize(title: MyInfo.allSection[indexPath.section][indexPath.item].rowTitle)
        default:
            return .zero
        }
    }
    
}



