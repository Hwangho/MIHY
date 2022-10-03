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
    
    var PolicydataArray: [RealmPolicySupport] = []
    
    var policySectionDataArray: [SectionPolicySupport] = []
    
    var isPagenating = false
    
    
    init(service: PolicyRepositoryProtocol = PolicyRepository() ) {
        self.service = service
    }
    
    
    func featch(pageNation: Bool, page: Int, handler: @escaping() ->() ) {
        if pageNation {
            isPagenating = true
        }
        
        realmService.featchData()
        guard let UserData = realmService.userData.first else { return }
        
        let policy = UserData.category
        let policySupport = policy.compactMap{ $0 }.joined(separator: ",")
        
        var region: Region?
        if !UserData.region!.isEmpty {
            region = Region(rawValue: UserData.region!)!
        }
        let city = region == nil ? "" : region!.rawValue
        
        service.fetchPolicyData(policySupport: policySupport, city: city, page: page) { [weak self] dataArray in
            if page == 1 {
                self?.PolicydataArray = []
            }
            
            dataArray.forEach { data in
                self?.PolicydataArray.append(data)
            }
            
            self?.fetchSectionData {
                if pageNation {
                    self?.isPagenating = false
                }
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
            if realmData.makeArray().isEmpty {
                newData.append(data)
            }
            else if !realmData.makeArray().contains(where: { realmData in           /// contain은 하나라도 포함이 되어 있으면 true를 반환하므로 같은 값이 있을경우의 반대로 작성!
                data.policyID == realmData.policyID }) {
                newData.append(data)
            }
            else {
                realmData.makeArray().map { realmData in
                    if data.policyID == realmData.policyID && realmData.isHidden == false {
                        oldData.append(realmData)
                    }
                }
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
