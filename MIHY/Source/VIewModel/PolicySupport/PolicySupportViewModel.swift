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
    
    var data: [PolicySupport] = []
    
    let service: PolicyRepositoryProtocol
    
    let realmService = RealmService(type: .nothidden)
    
        
    init(service: PolicyRepositoryProtocol = PolicyRepository() ) {
        self.service = service
    }
    
    func setdata() {
        
    }
}
