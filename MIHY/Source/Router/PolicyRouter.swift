//
//  PolicyRouter.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import Alamofire


enum Router {
    case Policy(city: String, district: String)
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
        case .Policy(let city, let district):
            return ["openApiVlak": APIKey.key,
                    "pageIndex": 1,
                    "display": 100,
//                    "query": "청년취업",
//                    "srchPolicyId": "R2020123101105",
                    "bizTycdSel": city,
                    "srchPolyBizSecd": district,
            ]
        }
    }

}



