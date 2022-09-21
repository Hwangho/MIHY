//
//  OnBoardingCollectionViewModel.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/21.
//

import Foundation


class OnBoardingCollectionViewModel {
    
    let type: OnBoardingQuestionType
    
    var policyDatas: [PolicyType.caseType: [String]] = [:]
    
    var regionData: Region?
    
    var myInfoDatas: [MyInfo.caseType: [String]] = [:]
    
    
    init(type: OnBoardingQuestionType) {
        self.type = type
    }
    
    
    func appendPolicyData(key: PolicyType.caseType, value: String) {
        policyDatas[key, default: []].append(value)
    }
    
    func deletePolicyData(key: PolicyType.caseType, value: String) {
        if let index = policyDatas[key, default: []].firstIndex(of: value) {
            policyDatas[key, default: []].remove(at: index)
        }
        if policyDatas[key]!.isEmpty {policyDatas[key] = nil }
    }
    
    func updateRegion(type: Region) {
        regionData = type
    }
    
    func appendmyInfoData(key: MyInfo.caseType, value: String) {
        myInfoDatas[key, default: []].append(value)
    }
    
    func deletemyInfoData(key: MyInfo.caseType, value: String) {
        if let index = myInfoDatas[key, default: []].firstIndex(of: value) {
            myInfoDatas[key, default: []].remove(at: index)
        }
        if myInfoDatas[key]!.isEmpty { myInfoDatas[key] = nil }
    }
}
