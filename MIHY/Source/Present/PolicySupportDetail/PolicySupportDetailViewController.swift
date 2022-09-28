//
//  PolicySupportDetailViewController.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/26.
//

import UIKit

import SnapKit
import SafariServices


class PolicySupoortDetailViewController: BaseViewController {
    
    /// UI
    let scrollview = UIScrollView()
    
    let stackView = UIStackView()
    
    lazy var policySupportDetailNameView = PolicySupportDetailContentView(data: viewModel.data)
    
    lazy var policySupportDetailPeriodView = PolicySupportDetailPeriodView(data: viewModel.data)
    
    lazy var policySupportDetailApllyQulificationView = PolicySupportDetailApllyQulificationView(data: viewModel.data)
    
    lazy var policySupportDetailProcessView = PolicySupportDetailProcessView(data: viewModel.data)
    
    lazy var policySupportPeriodDetailView = PolicySupportPeriodDetailView(data: viewModel.data)

    
    /// Variable
    var viewModel =  PolicySupoortDetailViewModel()
    
    
    /// initialziation
    init(data: RealmPolicyData?) {
        viewModel.data = data
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Life Cycle
    override func setupAttributes() {
        super.setupAttributes()
        navigationItem.title = "상세 정보"
        
        stackView.axis = .vertical
        scrollview.backgroundColor = .clear
        
        policySupportPeriodDetailView.delegate = self
    }
    
    override func setupLayout() {
        
        [policySupportDetailNameView,
         policySupportDetailPeriodView,
         policySupportDetailApllyQulificationView,
         policySupportDetailProcessView,
         policySupportPeriodDetailView].forEach { view in
            stackView.addArrangedSubview(view)
        }

        scrollview.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.frame.width)
        }
        
        view.addSubview(scrollview)
        scrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}


extension PolicySupoortDetailViewController: TapURLButtonDelegate {

    func tapActionButton(url: String?) {
        guard let url = url else { return }

        if url.isValidUrl() {
            guard let blogUrl = NSURL(string: url) as? URL else { return }
            let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl)
            transition(blogSafariView, transitionStyle: .present)
        }        
    }
    
    func tapCopy() {
        showAlertMessage(title: "복사되었습니다.")
    }
}


class PolicySupoortDetailViewModel {
    var data: RealmPolicyData?

}
