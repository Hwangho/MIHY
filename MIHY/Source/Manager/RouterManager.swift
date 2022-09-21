//
//  RouterManager.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/21.
//

import UIKit

import Alamofire


struct RouterManager {
   
   static let `default` = RouterManager()
    
   private init() {}
    
    func createProvider<T>() -> Provider<T> {
        return Provider()
    }
    
    func provider<T: RouterProtocol>(target: T.Type) -> Provider<T>? {
        return Provider<T>()
    }
   
}



protocol ProviderType: AnyObject {
    func AFRequest(target: RouterProtocol) -> DataRequest
}

class Provider<Target: RouterProtocol>: ProviderType {
    
    func AFRequest(target: RouterProtocol) -> DataRequest {
        return AF.request(target.path, method: target.method, parameters: target.parameter)
    }

}
