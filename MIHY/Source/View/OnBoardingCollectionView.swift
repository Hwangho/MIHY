//
//  OnBoardingCollectionView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/17.
//

import UIKit
import SwiftUI


class OnBoardingCollectionView: BaseView {
    
    let collectionView: UICollectionView = {
        let layout = TagFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 100, right: 15)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    
    /// Variable
    let type: OnBoardingQuestionType
    
    lazy var viewModel = OnBoardingCollectionViewModel(type: type)
    
    var array: [PolicyType] = []
    
    
    // Initialize
    init(type: OnBoardingQuestionType) {
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    // Life Cycle
    override func setupAttributes() {
        super.setupAttributes()
        collectionViewdelegate()
//        backgroundColor = .orange
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
            cell.titleLabel.text = PolicyType.allSection[indexPath.section][indexPath.row].rowTitle
            return cell
        case .region:
            cell.titleLabel.text = Region.allCases[indexPath.row].title
            return cell
        case .myInfo:
            cell.titleLabel.text = MyInfo.allSection[indexPath.section][indexPath.row].rowTitle
            return cell
        default:
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OnBoardingCollectionViewHeaderView", for: indexPath) as? OnBoardingCollectionViewHeaderView else { return UICollectionReusableView() }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            header.titleLabel.text = PolicyType.allSection[indexPath.section][indexPath.row].sectionTitle
            return header
        default:
            assert(false, "Don't use this kind.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        
        return CGSize(width: width, height: 60)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch type {
        case .policy:
            array.append(PolicyType.allSection[indexPath.section][indexPath.row])
        case .region:
            print("지역 관련 데이터 저장")
        case .myInfo:
            print("내 정보 관련 데이터 저장")
        default:
            print("내 정보 관련 데이터 저장")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch type {
        case .policy:
            array.append(PolicyType.allSection[indexPath.section][indexPath.row])
        case .region:
            print("지역 관련 데이터 제거")
        case .myInfo:
            print("내 정보 관련 데이터 제거")
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
            assert(false, "잘못 들어감")
        }
    }
    
}




class OnBoardingCollectionViewModel {
    
    let type: OnBoardingQuestionType

    
    init(type: OnBoardingQuestionType) {
        self.type = type
    }
    
}
