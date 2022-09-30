//
//  PolicySupportViewModel.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import Foundation

import RealmSwift

class PolicySupportViewModel {
    
    
    var onBoardingData: [OnBoardingQuestionType: Any] = [:]
        
    let service: PolicyRepositoryProtocol
    
    let realmService = RealmService(type: .nothidden)
    
    var policyDataArray: [SectionPolicySupport] = []
    
        
    init(service: PolicyRepositoryProtocol = PolicyRepository() ) {
        self.service = service
    }
    
    func setdata() {
        policyDataArray = []
        let first = SectionPolicySupport(cellType: .onlyHeader, data: nil)
        let newPolicy = SectionPolicySupport(cellType: .newPolicy, data: realmService.PolicySupportData.where { $0.newPolicy == true} )
        let oldPolicy = SectionPolicySupport(cellType: .oldPolicy, data: realmService.PolicySupportData.where { $0.newPolicy == false} )
        
        policyDataArray.append(first)
        [newPolicy,oldPolicy].forEach { data in
            if !data.data!.isEmpty {
                policyDataArray.append(data)
            }
        }
        
    }
    
}
