//
//  RealmService.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/23.
//

import RealmSwift
import UIKit



final class RealmService {
    
    static let shared = RealmService()
    
    
    let localRealm = try! Realm()
    
    var PolicySupportData: Results<RealmPolicySupport>!
    
    var userData: Results<RealmUser>!
    
    
    
    
    /// User
    func featchData() {
        PolicySupportData = localRealm.objects(RealmPolicySupport.self)
        userData = localRealm.objects(RealmUser.self)
    }
    
    
    func addData(data: RealmUser) {
        do {
           try localRealm.write({
                localRealm.add(data)
            })
        } catch {
            print("메모를 추가하는데 error가 생겼습니다.")
        }
    }
    
    
    func deleData(data: ObjectBase) {
        do {
           try localRealm.write({
                localRealm.delete(data)
            })
        } catch {
            print("메모를 제거하는데 error가 생겼습니다.")
        }
    }
    
    func deleDataAll() {
        do {
           try localRealm.write({
                localRealm.deleteAll()
            })
        } catch {
            print("메모를 모두 제거하는데 error가 생겼습니다.")
        }
    }
    
    func modifyData(data: RealmUser) {
        do {
           try localRealm.write({
               guard let newUser = userData.first else {return}
               newUser.nickName = data.nickName
               newUser.birth = data.birth
               newUser.category = data.category
               newUser.region = data.region
               newUser.employment = data.employment
               newUser.Education = data.Education
               newUser.specialization = data.specialization
               newUser.data = data.data
               localRealm.add(newUser, update: .modified)
            })
        } catch {
            print("메모를 추가하는데 error가 생겼습니다.")
        }
    }
    
    func updateHiddenData(data: RealmPolicySupport) {
        
        do {
            try localRealm.write({
                
                data.isHidden = !data.isHidden
                data.newPolicy = false // 숨기게 되면 새로운 정책에서 제거
                
                if !PolicySupportData.makeArray().contains(where: { realmData in data.policyID == realmData.policyID }) {
                    guard let User = userData.first else {return}
                    User.data.append(data)
                } 
                
            })
        } catch {
            print("데이터 업데이트 못함")
        }
        featchData()
    }
    
    func updateClickData(data: RealmPolicySupport) {
        do {
           try localRealm.write({
               data.newPolicy = false
               if !PolicySupportData.makeArray().contains(where: { realmData in data.policyID == realmData.policyID }) {
                   guard let User = userData.first else {return}
                   User.data.append(data)
               }
            })
        } catch {
            print("신규 데이터 못 읽음")
        }
        featchData()
    }
    
}


extension RealmService {
    
    func fountRealmPath() {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        print("❤️document path ==== \(path)❤️")
    }
}




extension Results {
    func makeArray() -> [RealmPolicySupport] {
        return self.compactMap { $0 as? RealmPolicySupport }
    }
}


extension List {
    func makeArray() -> [RealmPolicySupport] {
        return self.compactMap { $0 as? RealmPolicySupport }
    }
    
    func makeListArray() -> [String] {
        return self.compactMap { $0 as? String }
    }
}
