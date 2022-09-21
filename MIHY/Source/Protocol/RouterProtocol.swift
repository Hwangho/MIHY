//
//  RouterProtocol.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import Alamofire


protocol RouterProtocol {
    var baseURL: String { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var parameter: [String: Any]? { get }
}
