//
//  PolicetRepository.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import Alamofire
import SWXMLHash
import RealmSwift


protocol PolicyRepositoryProtocol {
//    func fetchPolicyData(policySupport: String, city: String, handler: @escaping ([PolicySupport]) -> Void)
    func fetchPolicyData(policySupport: String, city: String, handler: @escaping ([RealmPolicySupport]) -> Void)
}


struct PolicyRepository: PolicyRepositoryProtocol {
    
    let router: Provider<Router>
    
    
    init(router: Provider<Router> = RouterManager.default.createProvider()) {
        self.router = RouterManager.default.provider(target: Router.self) ?? router
    }
    
    
    func fetchPolicyData(policySupport: String, city: String, handler: @escaping ([RealmPolicySupport]) -> Void) {
        
        router.AFRequest(target: Router.Policy(policySupport: policySupport, city: city, page: 1, display: 10)).validate().responseData { response in
            switch response.result {
            case .success(let value):
//                var datas: [PolicySupport] = []
                var realmDatas: [RealmPolicySupport] = []

                
                let xml = XMLHash.parse(value)
                let totalCount = Int(xml["empsInfo"]["totalCnt"].element?.text ?? "0")!
                let totalAPICount = totalCount/100 + 1
                
                for page in 1...totalAPICount {
                    router.AFRequest(target: Router.Policy(policySupport: policySupport, city: city, page: page, display: 100)).validate().responseData { response in
                        switch response.result {
                        case .success(let value):
                            
                            let xml = XMLHash.parse(value)
                            
                            xml["empsInfo"]["emp"].all.forEach { xml in
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
                                
//                                let data = PolicyData(ID: ID!,
//                                                      title: title!,
//                                                      introduce: introduce!,
//                                                      category: category!,
//                                                      age: age!,
//                                                      employment: employment!,
//                                                      Education: Education!,
//                                                      major: major!,
//                                                      period: period!,
//                                                      process: process!,
//                                                      applyURL: applyURL!)
                                
//                                let policyData = PolicySupport(isHidden: false, data: data)
                                let realmPolicyData = RealmPolicySupport(isHidden: false, data: realmData)
                                
//                                datas.append(policyData)
                                realmDatas.append(realmPolicyData)
                            }
                            
                            /// 마지막 for문을 돌고 api를 받았을 때 handler 처리
                            if page == totalAPICount {
                                handler(realmDatas)
                            }
                            
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

