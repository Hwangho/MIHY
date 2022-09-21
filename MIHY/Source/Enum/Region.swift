//
//  Region.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/20.
//

import Foundation


// MARK: - 지역 설정
enum Region: Int, CaseIterable {
    case all = 1
    case seoul = 003002001      // 서울
    case busan = 003002002      // 부산
    case daegu = 003002003      // 대구
    case incheon = 003002004    // 인천
    case gwangju = 003002005    // 광주
    case daejeon = 003002006    // 대전
    case ulsan = 003002007      // 울산
    case gyeonggi = 003002008   // 경기
    case ghangwon = 003002009   // 강원
    case chungbuk = 003002010   // 충북
    case chungnam = 003002011   // 충남
    case jeonbuk = 003002012    // 전북
    case jeonnam = 003002013    // 전남
    case gyeongbuk = 003002014  // 경북
    case gyeongnam = 003002015  // 경남
    case jeju = 003002016       // 제주
    case sejong = 003002017     // 세종
    
    
    var title: String {
        switch self {
        case .all:      return "전체"
        case .seoul:    return "서울"
        case .busan:    return "부산"
        case .daegu:    return "대구"
        case .incheon:  return "인천"
        case .gwangju:  return "광주"
        case .daejeon:  return "대전"
        case .ulsan:    return "울산"
        case .gyeonggi: return "경기"
        case .ghangwon: return "강원"
        case .chungbuk: return "충북"
        case .chungnam: return "충남"
        case .jeonbuk:  return "전북"
        case .jeonnam:  return "전남"
        case .gyeongbuk: return "경북"
        case .gyeongnam: return "경남"
        case .jeju:     return "제주"
        case .sejong:   return "세종"
        }
    }
}
