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
    
//    var data: [PolicySupport] = []
    
    let service: PolicyRepositoryProtocol
    
    let realmService = RealmService(type: .hidden)
    
    var policyDataArray: [SectionPolicySupport] = []
    
        
    init(service: PolicyRepositoryProtocol = PolicyRepository() ) {
        self.service = service
    }
    
    func setdata() {
        policyDataArray = []
        let newPolicy = SectionPolicySupport(cellType: .newPolicy, data: realmService.PolicySupportData.where { $0.newPolicy == true} )
        let oldPolicy = SectionPolicySupport(cellType: .oldPolicy, data: realmService.PolicySupportData.where { $0.newPolicy == false} )
        
        [newPolicy,oldPolicy].forEach { data in
            if !data.data!.isEmpty {
                policyDataArray.append(data)
            }
        }
        
    }
    
}
