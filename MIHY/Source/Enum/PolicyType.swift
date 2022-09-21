//
//  PolicyType.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/20.
//

import Foundation


// MARK: - 정책 유형
enum PolicyType: Hashable {
    
    enum caseType {
        case employSupport
        case foundedSupport
        case dwellingandFinance
        case lifeandWelfare
        case policyParticipation
        case corona
    }
    
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
        case .employSupport(let employSupport): return employSupport.rawValue
        case .foundedSupport(let foundedSupport): return foundedSupport.rawValue
        case .dwellingandFinance(let dwellingandFinance): return dwellingandFinance.rawValue
        case .lifeandWelfare(let lifeandWelfare): return lifeandWelfare.rawValue
        case .policyParticipation(let policyParticipation): return policyParticipation.rawValue
        case .corona(let corona): return corona.rawValue
        }
    }
    
    var checkedData: (PolicyType.caseType, String) {
        switch self {
        case .employSupport(let employSupport): return employSupport.data
        case .foundedSupport(let foundedSupport): return foundedSupport.data
        case .dwellingandFinance(let dwellingandFinance): return dwellingandFinance.data
        case .lifeandWelfare(let lifeandWelfare): return lifeandWelfare.data
        case .policyParticipation(let policyParticipation): return policyParticipation.data
        case .corona(let corona): return corona.data
        }
    }
    
}


// 1. 취업 지원
enum EmploySupport:String, CaseIterable {
    case all = "전체"
    case intern = "교육훈련·체험·인턴"
    case smallenterprise = "중소(중견)기업 취업지원"
    case Specialty = "전문분야 취업지원"
    case overseas = "해외진출"
    
    var data: (PolicyType.caseType, String) {
        switch self {
        case .all: return (.employSupport, "004001")
        case .intern: return (.employSupport, "004001001")
        case .smallenterprise: return (.employSupport, "004001002")
        case .Specialty: return (.employSupport, "004001003")
        case .overseas: return (.employSupport, "004001004")
        }
    }
}


// 2. 창업 지원
enum FoundedSupport: String, CaseIterable {
    case all = "전체"
    case resarch = "R&D 지원"
    case management = "경영 지원"
    case capital = "자본금 지원"
    
    var data: (PolicyType.caseType, String) {
        switch self {
        case .all: return (.foundedSupport, "004002")
        case .resarch: return (.foundedSupport, "004002001")
        case .management: return (.foundedSupport, "004002002")
        case .capital: return (.foundedSupport, "004002003")
        }
    }
}


// 3. 주거·금융
enum DwellingandFinance: String, CaseIterable {
    case all = "전체"
    case livingexpenses = "생활비지원 및 금융 혜택"
    case Housing = "주거지원"
    case capital = "학자금 지원"
    
    var data: (PolicyType.caseType, String) {
        switch self {
        case .all: return (.dwellingandFinance, "004003")
        case .livingexpenses: return (.dwellingandFinance, "004003001")
        case .Housing: return (.dwellingandFinance, "004003002")
        case .capital: return (.dwellingandFinance, "004003003")
        }
    }
}


// 4. 생활·복지
enum LifeandWelfare: String, CaseIterable {
    case all = "전체"
    case health = "건강"
    case culture = "문화"
    
    var data: (PolicyType.caseType, String) {
        switch self {
        case .all: return (.lifeandWelfare, "004004")
        case .health: return (.lifeandWelfare, "004004001")
        case .culture: return (.lifeandWelfare, "004004002")
        }
    }
}


// 5. 정책참여
enum PolicyParticipation: String, CaseIterable {
    case all = "전체"
    case Proposal = "정책제안"
    case protection = "권리보호"
    case regionDevelopment = "지역발전"
    
    var data: (PolicyType.caseType, String) {
        switch self {
        case .all: return (.policyParticipation, "004005")
        case .Proposal: return (.policyParticipation, "004005001")
        case .protection: return (.policyParticipation, "004005002")
        case .regionDevelopment: return (.policyParticipation, "004005003")
        }
    }
}


// 6. 코로나19
enum Corona: String, CaseIterable {
    case all = "전체"
    case basicIncome = "기본소득지원"
    case lowIncome = "저소득층지원"
    case disasterDamage = "재난피해지원"
    case jobpreservation = "소득및일자리보전"
    case incentive = "인센티브"
    case psychological = "심리지원"
    
    var data: (PolicyType.caseType, String) {
        switch self {
        case .all: return (.corona, "004006")
        case .basicIncome: return (.corona, "004006001")
        case .lowIncome: return (.corona, "004006002")
        case .disasterDamage: return (.corona, "004006003")
        case .jobpreservation: return (.corona, "004006004")
        case .incentive: return (.corona, "004006005")
        case .psychological: return (.corona, "004006006")
        }
    }
}
