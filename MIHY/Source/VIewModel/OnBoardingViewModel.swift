//
//  OnBoardingViewModel.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/17.
//

import Foundation


class OnBoardingViewModel {

    var onBoardingData: [OnBoardingQuestionType: Any] = [:]
    
    
    func addData(key: OnBoardingQuestionType, value: Any?) {
        guard let value = value else { return }
        onBoardingData.updateValue(value, forKey: key)
    }
}
