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
    
    var userData: User?
    
    let realmService = RealmService()
    
    
    func addData(key: OnBoardingQuestionType, value: Any?) {
        guard let value = value else { return }
        onBoardingData.updateValue(value, forKey: key)
    }
    
    func myDataapi(_ handler: @escaping(User) -> ()) {
        let nickName = onBoardingData[.nickName] as? String
        let birth = onBoardingData[.birth] as? String
        
        let policy = onBoardingData[.policy] as? [PolicyType.caseType: [String]]
        let policySupport = policy!.values.flatMap { $0 }.joined(separator: ", ")
        
        let region = onBoardingData[.region] as? Region
        let city = region == nil ? "" : region!.rawValue
        
        let myInfo = onBoardingData[.myInfo] as? [MyInfo.caseType: [String]]
        
        service.fetchPolicyData(policySupport: policySupport, city: city) { data in
            let user: User = User(nickName: nickName!,
                                  birth: birth,
                                  category: policy!.values.flatMap { $0 },
                                  region: city,
                                  employment: myInfo?[.employmentStatus],
                                  Education: myInfo?[.education],
                                  specialization: myInfo?[.specialization],
                                  data: data)

//            let realmUser: RealmUser = RealmUser(nickName: nickName!,
//                                                 birth: birth,
//                                                 category: policy!.values.flatMap { $0 },
//                                                 region: city,
//                                                 employment: myInfo?[.employmentStatus],
//                                                 Education: myInfo?[.education],
//                                                 specialization: myInfo?[.specialization],
//                                                 data: data)
            
            self.userData = user
            handler(user)
        }    
    }
    
}