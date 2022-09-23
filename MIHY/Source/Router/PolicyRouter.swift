//
//  PolicyRouter.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import Alamofire


enum Router {
    case Policy(policySupport: String, city: String, page: Int, display: Int)
}


extension Router: RouterProtocol {
    
    public var baseURL: String {
        return "https://www.youthcenter.go.kr/opi/"
    }
    
    public var path: String {
        switch self {
        case .Policy:
            return baseURL + "empList.do"
        }
    }
    
   public var method: HTTPMethod {
        switch self {
        case .Policy:
            return .get
        }
    }
    
    var parameter: [String : Any]? {
        switch self {
        case .Policy(let policySupport, let city, let page, let display):
            return ["openApiVlak": APIKey.key,
                    "pageIndex": page,
                    "display": display,
//                    "query": "청년취업",
//                    "srchPolicyId": "R2020123101105",
                    "bizTycdSel": policySupport,
                    "srchPolyBizSecd": city,
            ]
        }
    }

}



