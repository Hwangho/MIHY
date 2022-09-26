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
    
    var userData: Results<RealmUser>!
    
    let type: dataType
    
    
    /// initialization
    init(type: dataType = .all) {
        self.type = type
    }
    
    
    /// User
    func featchData() {
        switch type {
        case .hidden:
            userData = localRealm.objects(RealmUser.self).where{  $0.data.isHidden == false }
        case .nothidden:
            userData = localRealm.objects(RealmUser.self).where{  $0.data.isHidden == true }            
        case .all:
            userData = localRealm.objects(RealmUser.self)
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
    
    func updateHiddenData(item: Int) {
        guard let task = userData.first?.data[item] else { return }
        
        do {
           try localRealm.write({
               task.isHidden = !task.isHidden
               task.newPolicy = !task.newPolicy // 숨기게 되면 새로운 정책에서 제거
            })
        } catch {
            print("checkBox 변경 안됨")
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
