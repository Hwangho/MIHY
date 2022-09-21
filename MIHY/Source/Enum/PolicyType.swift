//
//  PolicyType.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/20.
//

import Foundation


// MARK: - 정책 유형

enum PolicyType {
    
    static var allSection: [[PolicyType]] {
        return[ EmploySupport.allCases.map{.employSupport($0)},
                FoundedSupport.allCases.map{.foundedSupport($0)},
                DwellingandFinance.allCases.map{.dwellingandFinance($0)},
                LifeandWelfare.allCases.map{.lifeandWelfare($0)},
                PolicyParticipation.allCases.map{.policyParticipation($0)},
                Corona.allCases.map{.corona($0)}
        ]
    }
    
    case employSupport(EmploySupport)
    case foundedSupport(FoundedSupport)
    case dwellingandFinance(DwellingandFinance)
    case lifeandWelfare(LifeandWelfare)
    case policyParticipation(PolicyParticipation)
    case corona(Corona)
    
    var sectionTitle: String {
        switch self {
        case .employSupport: return "취업 지원"
        case .foundedSupport: return "창업 지원"
        case .dwellingandFinance: return "주거·금융"
        case .lifeandWelfare: return "생활·복지"
        case .policyParticipation: return "정책참여"
        case .corona: return "코로나19"
        }
    }
    
    var rowTitle: String {
        switch self {
        case .employSupport(let employSupport): return employSupport.title
        case .foundedSupport(let foundedSupport): return foundedSupport.title
        case .dwellingandFinance(let dwellingandFinance): return dwellingandFinance.title
        case .lifeandWelfare(let lifeandWelfare): return lifeandWelfare.title
        case .policyParticipation(let policyParticipation): return policyParticipation.title
        case .corona(let corona): return corona.title
        }
    }
    
    var rawValue: Int {
        switch self {
        case .employSupport(let employSupport): return employSupport.rawValue
        case .foundedSupport(let foundedSupport): return foundedSupport.rawValue
        case .dwellingandFinance(let dwellingandFinance): return dwellingandFinance.rawValue
        case .lifeandWelfare(let lifeandWelfare): return lifeandWelfare.rawValue
        case .policyParticipation(let policyParticipation): return policyParticipation.rawValue
        case .corona(let corona): return corona.rawValue
        }
    }
}



// 1. 취업 지원
enum EmploySupport: Int, CaseIterable {
    case all = 004001                   // 전체
    case intern = 004001001             // 교육훈련·체험·인턴
    case smallenterprise = 004001002    // 중소(중견)기업 취업지원
    case Specialty = 004001003          // 전문분야 취업지원
    case overseas = 004001004           // 해외진출
    
    var title: String {
        switch self {
        case .all: return "전체"
        case .intern: return "교육훈련·체험·인턴"
        case .smallenterprise: return "중소(중견)기업 취업지원"
        case .Specialty: return "전문분야 취업지원"
        case .overseas: return "해외진출"
        }
    }
}


// 2. 창업 지원
enum FoundedSupport: Int, CaseIterable {
    case all = 004002              // 전체
    case resarch = 004002001       // R&D 지원
    case management = 004002002    // 경영 지원
    case capital = 004002003       // 자본금 지원
    
    var title: String {
        switch self {
        case .all: return "전체"
        case .resarch: return "R&D 지원"
        case .management: return "경영 지원"
        case .capital: return "자본금 지원"
        }
    }
}


// 3. 주거·금융
enum DwellingandFinance: Int, CaseIterable {
    case all = 004003               // 전체
    case livingexpenses = 004003001 // 생활비지원 및 금융 혜택
    case Housing = 004003002        // 주거지원
    case capital = 004003003        // 학자금 지원
    
    var title: String {
        switch self {
        case .all: return "전체"
        case .livingexpenses: return "생활비지원 및 금융 혜택"
        case .Housing: return "주거지원"
        case .capital: return "학자금 지원"
        }
    }
}

// 4. 생활·복지
enum LifeandWelfare: Int, CaseIterable {
    case all = 004004           // 전체
    case health = 004004001     // 건강
    case culture = 004004002    // 문화
    
    var title: String {
        switch self {
        case .all: return "전체"
        case .health: return "건강"
        case .culture: return "문화"
        }
    }
}

// 5. 정책참여
enum PolicyParticipation: Int, CaseIterable {
    case all = 004005                   // 전체
    case Proposal = 004005001           // 정책제안
    case protection = 004005002         // 권리보호
    case regionDevelopment = 004005003  // 지역발전
    
    var title: String {
        switch self {
        case .all: return "전체"
        case .Proposal: return "정책제안"
        case .protection: return "권리보호"
        case .regionDevelopment: return "지역발전"
        }
    }
}


// 6. 코로나19
enum Corona: Int, CaseIterable {
    case all = 004006                   // 전체
    case basicIncome = 004006001        // 기본소득지원
    case lowIncome = 004006002          // 저소득층지원
    case disasterDamage = 004006003     // 재난피해지원
    case jobpreservation = 004006004    // 소득및일자리보전
    case incentive = 004006005          // 인센티브
    case psychological = 004006006      // 심리지원
    
    var title: String {
        switch self {
        case .all: return "전체"
        case .basicIncome: return "기본소득지원"
        case .lowIncome: return "저소득층지원"
        case .disasterDamage: return "재난피해지원"
        case .jobpreservation: return "소득및일자리보전"
        case .incentive: return "인센티브"
        case .psychological: return "심리지원"
        }
    }
}


