//
//  User.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/13.
//

import Foundation

struct User {
    var nickName: String
    var birth: String              // 생년월일
    var category: [Int]?           // User 정책유형
    var region: [Int]?             // User 지역
    var employment: [String]?      // User 취업 상태
    var Education: [String]?       // User 학력
    var major: [String]?           // User 전공
    var data: [PolicySupport]
}
