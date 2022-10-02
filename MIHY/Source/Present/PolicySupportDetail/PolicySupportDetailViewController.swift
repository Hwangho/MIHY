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
    
    lazy var policySupportDetailNameView = PolicySupportDetailContentView()
    
    lazy var policySupportDetailPeriodView = PolicySupportDetailPeriodView()
    
    lazy var policySupportDetailApllyQulificationView = PolicySupportDetailApllyQulificationView()
    
    lazy var policySupportDetailProcessView = PolicySupportDetailProcessView()
    
    lazy var policySupportPeriodDetailView = PolicySupportPeriodDetailView()

    
    /// Variable
    var viewModel =  PolicySupoortDetailViewModel()
    
    let service: PolicyRepositoryProtocol
    
    
    /// initialziation
    init(policyid: String, service: PolicyRepositoryProtocol = PolicyRepository()) {
        self.service = service
        super.init()
        self.fetchDetailData(id: policyid)
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
    
    override func setupBinding() {
        viewModel.data.bind({ [weak self] data in
            guard let data = data else { return }

            self?.policySupportDetailNameView.configure(data: data)
            self?.policySupportDetailPeriodView.configure(data: data)
            self?.policySupportDetailApllyQulificationView.configure(data: data)
            self?.policySupportDetailProcessView.configure(data: data)
            self?.policySupportPeriodDetailView.configure(data: data)
            
        })
    }

    
    func fetchDetailData(id: String) {
        service.fetchDetailPolicyData(id: id) { [weak self] DetailData in
            self?.viewModel.data.value = DetailData
        }
    }
}


extension PolicySupoortDetailViewController: TapURLButtonDelegate {

    func tapActionButton() {
        guard let url = viewModel.data.value?.applyURL else { return }
        
        if url.isValidUrl() {
            guard let blogUrl = NSURL(string: url) as? URL else { return }
            let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl)
            transition(blogSafariView, transitionStyle: .present)
        }        
    }
    
    func tapCopy() {
        UIPasteboard.general.string = viewModel.data.value?.applyURL
        showAlertMessage(title: "복사되었습니다.")
    }
}


class PolicySupoortDetailViewModel {
    var data: Observable<PolicySupport?> = Observable(nil)

}
