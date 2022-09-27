//
//  PolicySupport.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import Foundation

import RealmSwift


struct PolicySupport {
    var isHidden: Bool
    var data: PolicyData
}


struct PolicyData {
    var ID: String              // ID 값
    var title: String           // 청책 이름
    var introduce: String       // 정책 소개
    var category: String        // 정책유형
    var age: String             // 참여 가능 나이
    var employment: String      // 취업 상태
    var Education: String       // 학력
    var major: String           // 전공
    var period: String          // 신청기간
    var process: String         // 신청 절차
    var applyURL: String        // 지원 홈페이지
}

class RealmPolicySupport: Object {
    @Persisted var isHidden: Bool
    @Persisted var newPolicy: Bool
    @Persisted var data: RealmPolicyData?

    convenience init(newPolicy: Bool = true, isHidden: Bool, data: RealmPolicyData) {
        self.init()
        self.newPolicy = newPolicy
        self.isHidden = isHidden
        self.data = data
    }
}


class RealmPolicyData: Object {
    @Persisted var policyID: String        // ID 값
    @Persisted var title: String           // 청책 이름
    @Persisted var introduce: String       // 정책 소개
    @Persisted var category: String        // 정책유형
    @Persisted var age: String             // 참여 가능 나이
    @Persisted var employment: String      // 취업 상태
    @Persisted var Education: String       // 학력
    @Persisted var major: String           // 전공
    @Persisted var period: String          // 신청기간
    @Persisted var process: String         // 신청 절차
    @Persisted var applyURL: String        // 지원 홈페이지

    convenience init(policyID: String, title: String, introduce: String, category: String, age: String, employment: String, Education: String, major: String, period: String, process: String, applyURL: String) {
        self.init()
        self.policyID = policyID
        self.title = title
        self.introduce = introduce
        self.category = category
        self.age = age
        self.employment = employment
        self.Education = Education
        self.major = major
        self.period = period
        self.process = process
        self.applyURL = applyURL
    }
}


struct SectionPolicySupport {
    enum type {
        case onlyHeader
        case newPolicy
        case oldPolicy
        
        var title: String {
            switch self {
            case .onlyHeader: return ""
            case .newPolicy: return "신규 정책"
            case .oldPolicy: return "정책"
            }
        }
    }
    
    var cellType: type
    var data: Results<RealmPolicySupport>?
}

