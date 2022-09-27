//
//  RealmService.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/23.
//

import RealmSwift
import UIKit



class RealmService {
    
    enum dataType {
        case all
        case hidden
        case nothidden
    }
    
    
    let localRealm = try! Realm()
    
    var PolicySupportData: Results<RealmPolicySupport>!
    
    let type: dataType
    
    
    /// initialization
    init(type: dataType = .all) {
        self.type = type
    }
    
    
    /// User
    func featchData() {
        switch type {
        case .hidden:
            PolicySupportData = localRealm.objects(RealmPolicySupport.self).where{  $0.isHidden == true }
        case .nothidden:
            PolicySupportData = localRealm.objects(RealmPolicySupport.self).where{  $0.isHidden == false }
        case .all:
            PolicySupportData = localRealm.objects(RealmPolicySupport.self)
        }
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
            })
        } catch {
            print("데이터 업데이트 못함")
        }
        featchData()
    }
    
    func updateClickData(data: RealmPolicySupport) {
        
        do {
           try localRealm.write({
               data.newPolicy = false //
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
}
