//
//  OnBoardingViewController.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/14.
//

import UIKit

import SnapKit


class OnBoardingViewController: BaseViewController {
    
    // View
    let scrollView = UIScrollView()
    
    let stackView = UIStackView()
    
    let nextButton = UIButton()
    
    lazy var onBoardingTextFieldView: OnBoardingTextFieldView = {
       return OnBoardingTextFieldView(type: onBoardingType)
    }()
    
    lazy var onBoardingCollectionView: OnBoardingCollectionView = {
        return OnBoardingCollectionView(type: onBoardingType)
    }()
    
    
    // Variable
    let onBoardingType: OnBoardingQuestionType
    
    var viewModel: OnBoardingViewModel
    
    
    // Initialize
    init(type: OnBoardingQuestionType = OnBoardingQuestionType.nickName, viewModel: OnBoardingViewModel = OnBoardingViewModel()) {
        self.onBoardingType = type
        self.viewModel = viewModel
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        onBoardingTextFieldView.textField.resignFirstResponder()
        self.removeKeyboardNotifications()
    }
    
    
    override func setupAttributes() {
        super.setupAttributes()
        setNavigation()
        
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
            
        case .policy, .region, .myInfo:
            view.addSubview(onBoardingCollectionView)
            onBoardingCollectionView.snp.makeConstraints { make in
                make.edges.equalTo(view.safeAreaLayoutGuide)
            }
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
    }
    
    override func setData() {
        
    }
    
    func setNavigation() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = onBoardingType.title
        
        let backButton  = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    
    // 노티피케이션을 추가하는 메서드
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            nextButton.frame.origin.y -= keyboardHeight
        }
    }

    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            nextButton.frame.origin.y += keyboardHeight
        }
    }
    
    @objc
    func tapdoneButton() {
        switch onBoardingType {
        case .nickName, .birth:
            let value = onBoardingTextFieldView.textField.text
            viewModel.addData(key: onBoardingType, value: value)
        
        case .policy:
            print("policy")
        case .region:
            print("region")
        case .myInfo:
            print("myInfo")
        }
        
        guard let type = onBoardingType.nextOnBoarding else { return }
        let viewController = OnBoardingViewController(type: type, viewModel: viewModel)
        transition(viewController, transitionStyle: .push)
    }
    
    
}




