//
//  OnBoardingQuestionType.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/20.
//

import Foundation


enum OnBoardingQuestionType: String, CaseIterable {
    case nickName
    case birth
    case policy
    case region
    case myInfo
    
    var title: String {
        switch self {
        case .nickName: return "닉네임"
        case .birth: return "생년월일"
        case .policy: return "정책 유형"
        case .region: return "지역"
        case .myInfo: return "내 정보"
        }
    }
    
    var sectionTitle: String {
        switch self {
        case .nickName:
            return "닉네임을 입력해주세요."
        case .birth:
            return "생년월일을 입력해주세요."
        default:
            return ""
        }
    }
    
    var nextOnBoarding: OnBoardingQuestionType? {
        switch self {
        case .nickName: return .birth
        case .birth: return .policy
        case .policy: return .region
        case .region: return .myInfo
        case .myInfo: return nil
        }
    }
}


