//
//  OnBoardingCollectionViewModel.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/21.
//

import Foundation


class OnBoardingCollectionViewModel {
    
    let type: OnBoardingQuestionType
    
    var onBoardingData: [OnBoardingQuestionType: Any] = [:]
    
    var policyDatas: Observable<[PolicyType.caseType: [String]]> = Observable([:])
    
    var regionData: Observable<Region?> = Observable(nil)
    
    var myInfoDatas: Observable<[MyInfo.caseType: [String]]> = Observable([:])
    
    
    init(type: OnBoardingQuestionType) {
        self.type = type
    }
    
    
    func appendPolicyData(key: PolicyType.caseType, value: String) {
        policyDatas.value[key, default: []].append(value)
    }
    
    func deletePolicyData(key: PolicyType.caseType, value: String) {
        if let index = policyDatas.value[key, default: []].firstIndex(of: value) {
            policyDatas.value[key, default: []].remove(at: index)
        }
        if policyDatas.value[key]!.isEmpty {policyDatas.value[key] = nil }
    }
    
    func updateRegion(type: Region) {
        regionData.value = type
    }
    
    func appendmyInfoData(key: MyInfo.caseType, value: String) {
        myInfoDatas.value[key, default: []].append(value)
    }
    
    func deletemyInfoData(key: MyInfo.caseType, value: String) {
        if let index = myInfoDatas.value[key, default: []].firstIndex(of: value) {
            myInfoDatas.value[key, default: []].remove(at: index)
        }
        if myInfoDatas.value[key]!.isEmpty { myInfoDatas.value[key] = nil }
    }
    
    func checkisSelected(data: String) -> Bool {
        let dataArray = policyDatas.value.values.flatMap { $0 }
        return dataArray.contains(data)
    }
}
