//
//  BaseView.swift
//  SeSAC2DiaryRealm
//
//  Created by 황호 on 2022/08/21.
//

import UIKit


class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttributes()
        setupLayout()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setData() { }
    
    /**
     code로 Layout 잡을 때 해당 함수 내부에서 작성
     */
    func setupLayout() {
        // Override Layout
    }
    
    /**
     기본 속성(Attributes) 관련 정보 (ex Background Color,  Font Color ...)
     */
    func setupAttributes() {
        // Override Attributes
        self.backgroundColor = Color.BaseColor.background
    }
}

