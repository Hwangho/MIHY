//
//  PolicetRepository.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import Alamofire
import SWXMLHash


protocol PolicyRepositoryProtocol {
    func fetchPolicyData(city: String, district: String, handler: @escaping ([PolicySupport]) -> Void)
}


struct PolicyRepository: PolicyRepositoryProtocol {
    
    let router: Provider<Router>
    
    
    init(router: Provider<Router> = RouterManager.default.createProvider()) {
        self.router = RouterManager.default.provider(target: Router.self) ?? router
    }
    
    
    func fetchPolicyData(city: String, district: String, handler: @escaping ([PolicySupport]) -> Void) {
        
        router.AFRequest(target: Router.Policy(city: city, district: district)).validate().responseData { response in
            switch response.result {
            case .success(let value):
                var datas: [PolicySupport] = []
                
                let xml = XMLHash.parse(value)
                xml["empsInfo"]["emp"].all.forEach { xml in
                    
                    let ID = xml["bizId"].element?.text
                    let title = xml["polyBizSjnm"].element?.text
                    let introduce = xml["polyItcnCn"].element?.text
                    let category = xml["plcyTpNm"].element?.text
                    let age = xml["ageInfo"].element?.text
                    let employment = xml["empmSttsCn"].element?.text
                    let Education = xml["accrRqisCn"].element?.text
                    let major = xml["majrRqisCn"].element?.text
                    let period = xml["rqutPrdCn"].element?.text
                    let process = xml["rqutProcCn"].element?.text
                    let applyURL = xml["rqutUrla"].element?.text
                    
                    datas.append(PolicySupport(ID: ID!,
                                               title: title!,
                                               introduce: introduce!,
                                               category: category!,
                                               age: age!,
                                               employment: employment!,
                                               Education: Education!,
                                               major: major!,
                                               period: period!,
                                               process: process!,
                                               applyURL: applyURL!)
                    )
                }
                handler(datas)

            case .failure(let error):
                print(error)
            }
        }
    }
    
}

