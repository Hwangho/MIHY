//
//  OnBoardingTextFieldView.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/14.
//

import UIKit

import SnapKit


class OnBoardingTextFieldView: BaseView {
    
    /// UI
    var stackView = UIStackView()
    
    let contentTitle = UILabel()
    
    let textField = UITextField()
    
    let backView = UIView()
    
    
    /// Variable
    let type: OnBoardingQuestionType
    
    private let datePicker = UIDatePicker()
    
    private var diaryDate: Date?
    
    
    // Initialize
    init(type: OnBoardingQuestionType) {
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
    /// life Cycle
    override func setupAttributes() {
        super.setupAttributes()
        if type == .birth { setDatePicker() }
        
//        backgroundColor = .orange
        
        stackView.axis = .vertical
        stackView.spacing = 10
        
        backView.backgroundColor = Color.BaseColor.lightOrange
        backView.layer.cornerRadius = 10
    }
    
    override func setupLayout() {
        backView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        [contentTitle, backView].forEach { stackView.addArrangedSubview($0) }
        
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    
    override func setData() {
        contentTitle.text = type.sectionTitle
        textField.placeholder = "\(type.title)을 입력해주세요."
    }
    
    
    /// Custom Function
    private func setDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.maximumDate = Date()
        
        textField.inputView = datePicker
    }
    
    
    @objc
    private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일"
        formmater.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.textField.text = formmater.string(from: datePicker.date)
    }
    
}
