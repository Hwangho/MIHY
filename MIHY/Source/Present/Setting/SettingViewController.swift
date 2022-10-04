//
//  SettingViewController.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/29.
//

import UIKit

import SnapKit

class SettingViewController: BaseViewController {
    
    enum Setting: CaseIterable {
        case editeuser
//        case persona
//        case version
        
        var title: String {
            switch self {
            case .editeuser: return "정보 수정하기"
//            case .persona: return "새로운 나"
//            case .version: return "Version"
            }
        }
    }

    
    /// UI
    let tableView = UITableView()
    
    let viewModel = SettingViewModel()
    
    
    
    /// Life Cycle
    override func setupAttributes() {
        super.setupAttributes()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.title = "설정"
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func modifyAlert() {
        let alert = UIAlertController(title: "정보를 수정 하시겠습니까?", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "yes", style: .default) { [weak self] action in
            let viewController = OnBoardingViewController(isModify: true)
            self?.viewModel.changeDicData{ onBoardingData in
                viewController.viewModel.onBoardingData = onBoardingData
                self?.transition(viewController, transitionStyle: .presentFullNavigation)
            }
        }
        let cancel = UIAlertAction(title: "No", style: .cancel)
        alert.setTitle(font: Font.medium.scaledFont(to: 16), color: Color.BaseColor.title)
        alert.setTint(color: Color.BaseColor.thickOrange)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}


// MARK: - TableView 관련
extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = Setting.allCases[indexPath.row].title
        cell.textLabel?.font = Font.light.scaledFont(to: 14)
        cell.textLabel?.textColor = Color.BaseColor.title
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = Setting.allCases[indexPath.item]
        
        switch type {
        case .editeuser:
            modifyAlert()
//        case .persona:
//            print("페르소나 만들기")
//        case .version:
//            print("버전 정보")
        }
        
    }
    
}



