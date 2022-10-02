//
//  OnBoardingViewModel.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/17.
//

import Foundation

import RealmSwift


class OnBoardingViewModel {
    
    var onBoardingData: [OnBoardingQuestionType: Any] = [:]
    
    lazy var service = PolicyRepository()
    
    let realmService = RealmService.shared
    
    
    func addData(key: OnBoardingQuestionType, value: Any?) {
        guard let value = value else { return }
        onBoardingData.updateValue(value, forKey: key)
    }
    
    func myDataapi(isModify: Bool) {
        let nickName = onBoardingData[.nickName] as? String
        let birth = onBoardingData[.birth] as? String
        
        let policy = onBoardingData[.policy] as? [PolicyType.caseType: [String]]
        
        let region = onBoardingData[.region] as? Region
        let city = region == nil ? "" : region!.rawValue
        
        let myInfo = onBoardingData[.myInfo] as? [MyInfo.caseType: [String]]
        
        
        var realmData : [RealmPolicySupport]
        if let data = realmService.PolicySupportData {
            realmData = data.makeArray()
        } else {
            realmData = []
        }
//        let data = realmService.PolicySupportData?.makeArray()
        
        var realmUser: RealmUser
        
        realmUser = RealmUser(nickName: nickName!,
                              birth: birth,
                              category: policy!.values.flatMap { $0 },
                              region: city,
                              employment: myInfo?[.employmentStatus],
                              Education: myInfo?[.education],
                              specialization: myInfo?[.specialization],
                              data: isModify ? realmData : [])                         // 수정하기 일 경우 데이터 넣기~!
        
        realmService.deleDataAll()
        realmService.addData(data: realmUser)
    }
    
}
