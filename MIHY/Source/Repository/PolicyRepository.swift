//
//  PolicetRepository.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import Foundation

import Alamofire
import SWXMLHash
import RealmSwift
import UIKit


protocol PolicyRepositoryProtocol {
    func fetchPolicyData(policySupport: String, city: String, handler: @escaping ([RealmPolicySupport]) -> Void)
}


struct PolicyRepository: PolicyRepositoryProtocol {
    
    let router: Provider<Router>
    let dispatchGroup = DispatchGroup()
    
    init(router: Provider<Router> = RouterManager.default.createProvider()) {
        self.router = RouterManager.default.provider(target: Router.self) ?? router
    }
    
    
    func fetchPolicyData(policySupport: String, city: String, handler: @escaping ([RealmPolicySupport]) -> Void)  {
        var realmDatas: [RealmPolicySupport] = []
        
        router.AFRequest(target: Router.Policy(policySupport: policySupport, city: city, page: 1, display: 10)).validate().responseData { response in
            switch response.result {
            case .success(let value):
                
                let xml = XMLHash.parse(value)
                let totalCount = Int(xml["empsInfo"]["totalCnt"].element?.text ?? "0")!
                let totalAPICount = totalCount/100 + 1
                var valueCount = 0
                print(totalCount)
                
                
                for  page in 1...totalAPICount {
                    dispatchGroup.enter()
                    
                    
                    router.AFRequest(target: Router.Policy(policySupport: policySupport, city: city, page: page, display: 100)).validate().responseData { response in
                        switch response.result {
                        case .success(let value):
                            
                            let xmls = XMLHash.parse(value)
                            
                            xmls["empsInfo"]["emp"].all.forEach { xml in
                                let ID = xml["bizId"].element?.text as? String
                                let title = xml["polyBizSjnm"].element?.text
                                let introduce = xml["polyItcnCn"].element?.text
                                let category = xml["plcyTpNm"].element?.text
                                let age = xml["ageInfo"].element?.text
                                let employment = xml["empmSttsCn"].element?.text
                                let Education = xml["accrRqisCn"].element?.text
                                let major = xml["majrRqisCn"].element?.text
                                let specialization = xml["splzRlmRqisCn"].element?.text
                                let period = xml["rqutPrdCn"].element?.text
                                let process = xml["rqutProcCn"].element?.text
                                let applyURL = xml["rqutUrla"].element?.text
                                
                                let realmData = RealmPolicyData(policyID: ID ?? "",
                                                                title: title ?? "",
                                                                introduce: introduce ?? "",
                                                                category: category ?? "",
                                                                age:  age ?? "",
                                                                employment: employment ?? "",
                                                                education: Education ?? "",
                                                                specialization: specialization ?? "",
                                                                major: major ?? "",
                                                                period: period ?? "",
                                                                process: process ?? "",
                                                                applyURL: applyURL ?? "")
                                
                                let realmPolicyData = RealmPolicySupport(isHidden: false, data: realmData)
                                
                                realmDatas.append(realmPolicyData)
                                
                                print(realmDatas.count)
                            }
                            
                            /// 마지막 for문을 돌고 api를 받았을 때 handler 처리
                            dispatchGroup.leave()
                            
                        case .failure(let error):
                            print(error)
                        }
                        
                    }
                    
                }
                
                
                dispatchGroup.notify(queue: .main) {
                    handler(realmDatas)
                }
                
                
            case .failure(let error):
                print(error)
            }
            
        }
        

    }

    
}
    
