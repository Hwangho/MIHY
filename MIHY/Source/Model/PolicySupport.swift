//
//  PolicySupport.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import Foundation

import RealmSwift


class RealmPolicySupport: Object {
    @Persisted var isHidden: Bool
    @Persisted var newPolicy: Bool
    @Persisted var policyID: String        // ID
    @Persisted var title: String           // 청책 이름
    @Persisted var introduce: String       // 정책 소개
//    @Persisted var category: String        // 정책유형
//    @Persisted var age: String             // 참여 가능 나이
//    @Persisted var employment: String      // 취업 상태
//    @Persisted var education: String       // 학력
//    @Persisted var specialization: String  // 특화분야
//    @Persisted var major: String           // 전공
//    @Persisted var period: String          // 신청기간
//    @Persisted var process: String         // 신청 절차
//    @Persisted var applyURL: String        // 지원 홈페이지

    convenience init(newPolicy: Bool = true, isHidden: Bool = false, policyID: String, title: String, introduce: String) {
        self.init()
        self.newPolicy = newPolicy
        self.isHidden = isHidden
        self.policyID = policyID
        self.title = title
        self.introduce = introduce
    }
    
    convenience init(sample: Bool) {
        self.init()
        self.title = "이거는 스켈래톤 스켈래톤"
        self.introduce = "이거는 스켈래톤 뷰를 사용하기 위한 소개여 이거는 스켈래톤 뷰를 사용하기 위한 소개여 이거는 스켈래톤 뷰를 사용하기 위한 소개여"
    }
}


/// Detail 내부 전용 데이터 모델
struct PolicySupport {
    var ID: String              // ID 값
    var title: String           // 청책 이름
    var introduce: String       // 정책 소개
    var category: String        // 정책유형
    var age: String             // 참여 가능 나이
    var employment: String      // 취업 상태
    var education: String       // 학력
    var major: String           // 전공
    var specialization: String  // 특화분야
    var period: String          // 신청기간
    var process: String         // 신청 절차
    var applyURL: String        // 지원 홈페이지
}



/// tableview section용
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
    var data: [RealmPolicySupport]?
}

