//
//  User.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/13.
//

import Foundation

import RealmSwift
import UIKit


class RealmUser: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var nickName: String
    @Persisted var birth: String?                 // 생년월일
    @Persisted var category: List<String>         // User 정책유형
    @Persisted var region: String?                // User 지역
    @Persisted var employment: List<String>       // User 취업 상태
    @Persisted var Education: List<String>        // User 학력
    @Persisted var specialization: List<String>   // User 특화분야
    @Persisted var data: List<RealmPolicySupport>
    
    
    convenience init(nickName: String, birth: String?, category: [String]?, region: String?, employment: [String]?, Education: [String]?, specialization: [String]?, data: [RealmPolicySupport] ) {
       self.init()
        self.nickName = nickName
        self.birth = birth
        self.category = returnList(array: category)
        self.region = region
        self.employment = returnList(array: employment)
        self.Education = returnList(array: Education)
        self.specialization = returnList(array: specialization)
        self.data = returnList(array: data)

   }
    
    
   
    
    func returnList<T>(array: [T]?) -> List<T> {
        let dataList: List<T> = List<T>()
        dataList.append(objectsIn: array ?? [])
        
        return dataList
        
    }

}


