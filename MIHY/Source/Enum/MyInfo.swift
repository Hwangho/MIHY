//
//  MyInfo.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/20.
//

import Foundation



// MARK: - 내 정보

enum MyInfo {
    
    static var allSection: [[MyInfo]] {
        return[ EmploymentStatus.allCases.map{.employmentStatus($0)},
                Education.allCases.map{.education($0)},
                Specialization.allCases.map{.specialization($0)}
        ]
    }
    
    case employmentStatus(EmploymentStatus)
    case education(Education)
    case specialization(Specialization)
    
    var sectionTitle: String {
        switch self {
        case .employmentStatus: return "취업 상태"
        case .education: return "학력"
        case .specialization: return "특화분야"
        }
    }
    
    var rowTitle: String {
        switch self {
        case .employmentStatus(let employmentStatus): return employmentStatus.title
        case .education(let education): return education.title
        case .specialization(let specialization): return specialization.title
        }
    }
    
    var rawValue: String {
        switch self {
        case .employmentStatus(let employmentStatus): return employmentStatus.rawValue
        case .education(let education): return education.rawValue
        case .specialization(let specialization): return specialization.rawValue
        }
    }



}


// 1. 취업 상태
enum EmploymentStatus: String, CaseIterable {
    case all = "전체"                     // 전체
    case employed = "재직자"               // 재직자
    case unemployed = "미취업자"            // 미취업자
    case selfemployed = "자영업자"          // 자영업자
    case freelancer = "프피랜서"            // 프피랜서
    case dailyworker = "일용근로자"          // 일용근로자
    case prestartup = "(예비)창업자"         // (예비)창업자
    case shorttermworker = "단기근로자"      // 단기근로자
    case farmworker = "영농종사자"           // 영농종사자
    case nolimit = "제한 없음"              // 제한 없음
    
    var title: String {
        switch self {
        case .all: return "취업상태 전체"
        case .employed: return "재직자"
        case .unemployed: return "미취업자"
        case .selfemployed: return "자영업자"
        case .freelancer: return "프피랜서"
        case .dailyworker: return "일용근로자"
        case .prestartup: return "(예비)창업자"
        case .shorttermworker: return "단기근로자"
        case .farmworker: return "영농종사자"
        case .nolimit: return "제한 없음"
        }
    }
}


// 2. 학력
enum Education: String, CaseIterable {
    case all = "전체"                       // 전체
    case lessH = "고졸미만"                  // 고졸미만
    case attendingH = "고교재학"             // 고교재학
    case intendedgraduationH = "고졸예정"    // 고졸예정
    case graduationH = "고교졸업"            // 고교졸업
    case attendingC = "대학재학"             // 대학재학
    case intendedgraduationC = "대졸예정"    // 대졸예정
    case graduationC = "대학졸업"            // 대학졸업
    case master = "석·박사"                  // 석·박사
    case nolimit = "제한없음"                // 제한없음
    
    var title: String {
        switch self {
        case .all: return "학력 전체"
        case .lessH: return "고졸미만"
        case .attendingH: return "고교재학"
        case .intendedgraduationH: return "고졸예정"
        case .graduationH: return "고교졸업"
        case .attendingC: return "대학재학"
        case .intendedgraduationC: return "대졸예정"
        case .graduationC: return "대학졸업"
        case .master: return "석·박사"
        case .nolimit: return "제한없음"
        }
    }
}

// 3. 특화분야
enum Specialization: String, CaseIterable {
    case all = "전체"             // 전체
    case smallbusiness = "중소기업" // 중소기업
    case female = "여성"          // 여성
    case lowincome = "저소득층"     // 저소득층
    case Disabled = "장애인"       // 장애인
    case farmer = "농업인"         // 농업인
    case soldier = "군인"         // 군인
    case localtalent = "지역인재"  // 지역인재
    case nolimit = "제한없음"       // 제한없음
    
    var title: String {
        switch self {
        case .all: return "전체"
        case .smallbusiness: return "중소기업"
        case .female: return "여성"
        case .lowincome: return "저소득층"
        case .Disabled: return "장애인"
        case .farmer: return "농업인"
        case .soldier: return "군인"
        case .localtalent: return "지역인재"
        case .nolimit: return "제한없음"
        }
    }
}
