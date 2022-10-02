//
//  HiddenPolicySupportViewModel.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/27.
//

import Foundation

import RealmSwift

class HiddenPolicySupportViewModel {
    
    
    var onBoardingData: [OnBoardingQuestionType: Any] = [:]
    
    let service: PolicyRepositoryProtocol
    
    let realmService = RealmService.shared
    
    var policyDataArray: [RealmPolicySupport] = []
    
        
    init(service: PolicyRepositoryProtocol = PolicyRepository() ) {
        self.service = service
    }
    
    func setdata() {
        policyDataArray = []
        
        let isHiddenData = realmService.PolicySupportData.where{  $0.isHidden == true }
        policyDataArray = isHiddenData.isEmpty ? [] : isHiddenData.makeArray()
    }
    
}
