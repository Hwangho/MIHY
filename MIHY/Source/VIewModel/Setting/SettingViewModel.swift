//
//  SettingViewModel.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/29.
//

import RealmSwift


class SettingViewModel {
    
    let realmService = RealmService.shared
    
    var user: Results<RealmUser>!
    
    var onBoardingData: [OnBoardingQuestionType: Any] = [:]
    
    
    func changeDicData(complition: @escaping([OnBoardingQuestionType: Any]) -> () ) {
        
        user = realmService.localRealm.objects(RealmUser.self)
        
        guard let data = user.first as? RealmUser else { return }
        
        let nickName =  data.nickName
        let birth = data.birth
        
        var policy: [PolicyType.caseType: [String]] = [:]
        PolicyType.allSection.forEach { policyCase in
            policyCase.forEach { type in
                data.category.forEach { string in
                    if string == type.checkedData.1 {
                        if policy[type.checkedData.0] != nil {
                            policy[type.checkedData.0]?.append(type.checkedData.1)
                        } else {
                            policy.updateValue([type.checkedData.1], forKey: type.checkedData.0)
                        }
                    }
                }
            }
        }
        
        
        var region: Region?
        if !data.region!.isEmpty {
            region = Region(rawValue: data.region!)!
        }
         
        var employment: [MyInfo.caseType: [String]] = [:]
        var education: [MyInfo.caseType: [String]] = [:]
        var specialization: [MyInfo.caseType: [String]] = [:]
        
        MyInfo.allSection.forEach { myinfoCase in
            myinfoCase.forEach { type in
                data.employment.forEach { string in
                    if string == type.checkedData.1 {
                        if employment[type.checkedData.0] != nil {
                            employment[type.checkedData.0]?.append(type.rowTitle)
                        } else {
                            employment.updateValue([type.rowTitle], forKey: type.checkedData.0)
                        }
                    }
                }
                
                data.Education.forEach { string in
                    if string == type.checkedData.1 {
                        if education[type.checkedData.0] != nil {
                            education[type.checkedData.0]?.append(type.rowTitle)
                        } else {
                            education.updateValue([type.rowTitle], forKey: type.checkedData.0)
                        }
                    }
                }
                
                data.specialization.forEach { string in
                    if string == type.checkedData.1 {
                        if specialization[type.checkedData.0] != nil {
                            specialization[type.checkedData.0]?.append(type.rowTitle)
                        } else {
                            specialization.updateValue([type.rowTitle], forKey: type.checkedData.0)
                        }
                    }
                }
            }
        }
        
        addData(key: .nickName, value: nickName)
        addData(key: .birth, value: birth)
        addData(key: .policy, value: policy)
        addData(key: .region, value: region)
        addData(key: .myInfo, value: [employment, education, specialization])
              
        complition(onBoardingData)
    }
    
    func addData(key: OnBoardingQuestionType, value: Any?) {
        guard let value = value else { return }
        onBoardingData.updateValue(value, forKey: key)
    }
    
}
