//
//  PolicySupportViewModel.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import Foundation

class PolicySupportViewModel {
    
    let service: PolicyRepositoryProtocol
    
    var onBoardingData: [OnBoardingQuestionType: Any] = [:]
    
    var data: [PolicySupport] = []
    
    init(service: PolicyRepositoryProtocol = PolicyRepository() ) {
        self.service = service
    }
    
    func setdata() {
        service.fetchPolicyData(city: "004001,004002003", district: "003002001,003002002") { [weak self] value in
            self?.data = value
//            print(self?.data)
            dump(self?.data)
        }
        
    }
}
