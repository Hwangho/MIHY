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
//    func fetchPolicyData(policySupport: String, city: String, handler: @escaping ([RealmPolicySupport]) -> Void)
    func fetchPolicyData(policySupport: String, city: String, page: Int ,handler: @escaping ([RealmPolicySupport]) -> Void)
    func fetchDetailPolicyData(id: String, handler: @escaping (PolicySupport) -> Void) 
}


struct PolicyRepository: PolicyRepositoryProtocol {
    
    let router: Provider<Router>
    
    init(router: Provider<Router> = RouterManager.default.createProvider()) {
        self.router = RouterManager.default.provider(target: Router.self) ?? router
    }
    
    func fetchPolicyData(policySupport: String, city: String, page: Int, handler: @escaping ([RealmPolicySupport]) -> Void) {
        var policyDataArray: [RealmPolicySupport] = []
        
        router.AFRequest(target: Router.Policy(policySupport: policySupport, city: city, page: page, display: 100)).validate().responseData { response in
            switch response.result {
            case .success(let value):
                
                let xmls = XMLHash.parse(value)
                
                let totalCount = Int(xmls["empsInfo"]["totalCnt"].element?.text ?? "0")!
                UserDefaults.standard.set(totalCount, forKey: "totalCount")
                
                xmls["empsInfo"]["emp"].all.forEach { xml in
                    let ID = xml["bizId"].element?.text as? String
                    let title = xml["polyBizSjnm"].element?.text
                    let introduce = xml["polyItcnCn"].element?.text
//                    let category = xml["plcyTpNm"].element?.text
//                    let age = xml["ageInfo"].element?.text
//                    let employment = xml["empmSttsCn"].element?.text
//                    let Education = xml["accrRqisCn"].element?.text
//                    let major = xml["majrRqisCn"].element?.text
//                    let specialization = xml["splzRlmRqisCn"].element?.text
//                    let period = xml["rqutPrdCn"].element?.text
//                    let process = xml["rqutProcCn"].element?.text
//                    let applyURL = xml["rqutUrla"].element?.text
                    
                    let data = RealmPolicySupport(policyID: ID ?? "",
                                                  title: title ?? "",
                                                  introduce: introduce ?? "")

                    
                    policyDataArray.append(data)
                }
                
                handler(policyDataArray)
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    func fetchDetailPolicyData(id: String, handler: @escaping (PolicySupport) -> Void) {
        var DetailpolicyData: PolicySupport?
        
        router.AFRequest(target: Router.detail(id: id)).validate().responseData { response in
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
                    
                    let data = PolicySupport(ID: ID ?? "",
                                             title: title ?? "",
                                             introduce: introduce ?? "",
                                             category: category ?? "",
                                             age:  age ?? "",
                                             employment: employment ?? "",
                                             education: Education ?? "",
                                             major: specialization ?? "",
                                             specialization: major ?? "",
                                             period: period ?? "",
                                             process: process ?? "",
                                             applyURL: applyURL ?? "")
    
                    DetailpolicyData = data
                }
                
                guard let DetailpolicyData = DetailpolicyData else { return }
                handler(DetailpolicyData)
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}
    
