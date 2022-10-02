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
    
    let realmService = RealmService.shared
    
//    var PolicydataArray: Observable<[PolicySupport]> = Observable([])
    
    var PolicydataArray: [RealmPolicySupport] = []
    
    var policySectionDataArray: [SectionPolicySupport] = []
    
        
    init(service: PolicyRepositoryProtocol = PolicyRepository() ) {
        self.service = service
    }
    
    
    func featch(handler: @escaping() ->() ) {
        realmService.featchData()
        guard let UserData = realmService.userData.first else { return }
        
        let policy = UserData.category
        let policySupport = policy.compactMap{ $0 }.joined(separator: ",")
        
        var region: Region?
        if !UserData.region!.isEmpty {
            region = Region(rawValue: UserData.region!)!
        }
        let city = region == nil ? "" : region!.rawValue
        
        
        service.fetchPolicyData(policySupport: policySupport, city: city, page: 1) { [weak self] dataArray in
            self?.PolicydataArray = []
            dataArray.forEach { data in
                self?.PolicydataArray.append(data)
            }
            
            self?.fetchSectionData {
                handler()
            }
        }
        
    }
    
    
    func fetchSectionData(_ handler: @escaping()-> ()) {
        policySectionDataArray = []
        
        guard let realmData = realmService.PolicySupportData else { return }
        
        let first = SectionPolicySupport(cellType: .onlyHeader, data: nil)
        
        var newData: [RealmPolicySupport] = []
        var oldData: [RealmPolicySupport] = []
        
    
        let _ = PolicydataArray.map {  data in
            if realmData.makeArray().contains(where: { realmData in
                (data.policyID == realmData.policyID && realmData.isHidden == false)}) {
                oldData.append(data)
            } else {
                newData.append(data)
            }
        }

        let newPolicy = SectionPolicySupport(cellType: .newPolicy, data: newData )
        let oldPolicy = SectionPolicySupport(cellType: .oldPolicy, data: oldData )
        
        policySectionDataArray.append(first)
        [newPolicy,oldPolicy].forEach { data in
            if data.data != nil {
                if !data.data!.isEmpty {
                    policySectionDataArray.append(data)
                }
            }
        }
        handler()
    }
    
}
