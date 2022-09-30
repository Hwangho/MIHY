//
//  OnBoardingViewController.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/14.
//

import UIKit

import SnapKit


class OnBoardingViewController: BaseViewController {
    
    /// View
    private let scrollView = UIScrollView()
    
    private let stackView = UIStackView()
    
    private let nextButton = UIButton()
    
    lazy var onBoardingTextFieldView: OnBoardingTextFieldView = {
        return OnBoardingTextFieldView(type: onBoardingType, onboardingData: viewModel.onBoardingData)
    }()
    
    lazy var onBoardingCollectionView: OnBoardingCollectionView = {
        return OnBoardingCollectionView(type: onBoardingType, onboardingData: viewModel.onBoardingData)
    }()
    
    
    /// Variable
    private let onBoardingType: OnBoardingQuestionType
    
    var viewModel: OnBoardingViewModel
    
    let isModify: Bool
    
    
    /// Initialize
    init(type: OnBoardingQuestionType = .nickName, viewModel: OnBoardingViewModel = OnBoardingViewModel(), isModify: Bool = false) {
        self.onBoardingType = type
        self.viewModel = viewModel
        self.isModify = isModify
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onBoardingTextFieldView.textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        onBoardingTextFieldView.textField.resignFirstResponder()
        removeKeyboardNotifications()
    }
    
    override func setupAttributes() {
        super.setupAttributes()
        navigationAttribute()
        
        stackView.axis = .vertical
        stackView.spacing = 30
        
        nextButton.layer.cornerRadius = 15
        nextButton.backgroundColor = Color.BaseColor.thickOrange
        nextButton.addTarget(self, action: #selector(tapdoneButton), for: .touchUpInside)
    }
    
    override func setupLayout() {
        switch onBoardingType {
        case .nickName, .birth:
            view.addSubview(onBoardingTextFieldView)
            onBoardingTextFieldView.snp.makeConstraints { make in
                make.edges.equalTo(view.safeAreaLayoutGuide)
            }
            
            view.addSubview(nextButton)
            nextButton.snp.makeConstraints { make in
                make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(100)
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
                make.height.equalTo(50)
            }
            
        case .policy, .region, .myInfo:
            view.addSubview(onBoardingCollectionView)
            onBoardingCollectionView.snp.makeConstraints { make in
                make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            }
            
            view.addSubview(nextButton)
            nextButton.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(100)
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
                make.top.equalTo(onBoardingCollectionView.snp.bottom).offset(10)
                make.height.equalTo(50)
            }
        }
    }
    
    override func setupBinding() {
        switch onBoardingType {
        case .nickName:
            onBoardingTextFieldView.viewModel.textFieldText.bind { [weak self] text in
                self?.nextButton.setTitle("다음", for: .normal)
                self?.nextButton.isEnabled = text.isEmpty ? false : true
                self?.nextButton.backgroundColor = text.isEmpty ? Color.BaseColor.middleOrange : Color.BaseColor.thickOrange
            }
        case .birth:
            onBoardingTextFieldView.viewModel.textFieldText.bind { [weak self] text in
                self?.nextButton.setTitle(text.isEmpty ? "건너뛰기": "다음", for: .normal)
                self?.nextButton.backgroundColor = text.isEmpty ? Color.BaseColor.middleOrange : Color.BaseColor.thickOrange
            }
        case .policy:
            onBoardingCollectionView.viewModel.policyDatas.bind { [weak self] dic in
                self?.nextButton.setTitle(dic.values.isEmpty ? "건너뛰기": "다음", for: .normal)
                self?.nextButton.backgroundColor = dic.values.isEmpty ? Color.BaseColor.middleOrange : Color.BaseColor.thickOrange
            }
        case .region:
            onBoardingCollectionView.viewModel.regionData.bind { [weak self] region in
                self?.nextButton.setTitle(region == nil ? "건너뛰기": "다음", for: .normal)
                self?.nextButton.backgroundColor = region == nil ? Color.BaseColor.middleOrange : Color.BaseColor.thickOrange
            }
        case .myInfo:
            onBoardingCollectionView.viewModel.myInfoDatas.bind { [weak self] dic in
                self?.nextButton.setTitle("완료", for: .normal)
                self?.nextButton.backgroundColor = dic.values.isEmpty ? Color.BaseColor.middleOrange : Color.BaseColor.thickOrange
            }
        }
    }
    
    @objc
    func tapdoneButton() {
        switch onBoardingType {
        case .nickName, .birth:
            let value = onBoardingTextFieldView.viewModel.textFieldText.value
            self.viewModel.addData(key: self.onBoardingType, value: value)
            
        case .policy:
            let value = onBoardingCollectionView.viewModel.policyDatas.value
            viewModel.addData(key: onBoardingType, value: value)
            
        case .region:
            let value = onBoardingCollectionView.viewModel.regionData.value
            viewModel.addData(key: onBoardingType, value: value)
            
        case .myInfo:
            let value = onBoardingCollectionView.viewModel.myInfoDatas.value
            viewModel.addData(key: onBoardingType, value: value)
        }
        
        guard let type = onBoardingType.nextOnBoarding else {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            if isModify {
                viewModel.realmService.deleDataAll()
            }
            viewModel.myDataapi {[weak self] user in
                self?.viewModel.realmService.addData(data: user)
                
                UserDefaults.standard.set(true, forKey: "checkedSetData")
                let vc = TabbarViewController(index: .policy)
                sceneDelegate?.window?.rootViewController = vc
                UIView.transition(with: (sceneDelegate?.window)!, duration: 0.4, options: [.transitionCrossDissolve], animations: nil, completion: nil)
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            return
        }
        
        let viewController = OnBoardingViewController(type: type, viewModel: viewModel, isModify: isModify)
        transition(viewController, transitionStyle: .push)
    }
    
    func navigationAttribute() {
        navigationItem.title = onBoardingType.title
        
        if isModify {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(cancleButton))
        }
    }
    
    @objc
    func cancleButton() {
        dismiss(animated: true)
    }
}


// MARK: - keyBoard 관련
extension OnBoardingViewController {
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 0) {
                self.nextButton.frame.origin.y -= keyboardHeight
                self.nextButton.snp.updateConstraints { make in
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20 + keyboardHeight)
                }
            } completion: { _ in
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    func keyboardWillHide(_ noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0) {
                self.nextButton.frame.origin.y += keyboardHeight
                self.nextButton.snp.updateConstraints { make in
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
                }
            } completion: { _ in
                self.view.layoutIfNeeded()
            }
        }
    }
    
}
