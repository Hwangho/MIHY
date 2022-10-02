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
    
    func deleteDatas<T: Sequence>(data: T) where T.Iterator.Element: ObjectBase  {
        do {
           try localRealm.write({
                localRealm.delete(data)
            })
        } catch {
            print("메모를 제거하는데 error가 생겼습니다.")
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
    
    func updateHiddenData(data: RealmPolicySupport) {
        do {
            try localRealm.write({
                
                data.isHidden = !data.isHidden
                data.newPolicy = false // 숨기게 되면 새로운 정책에서 제거
                
                
                if PolicySupportData.makeArray().contains { realmData in data.policyID != realmData.policyID } {
                    localRealm.add(data)
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
               localRealm.add(data)
            })
        } catch {
            print("신규 데이터 못 읽음")
        }
        featchData()
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
