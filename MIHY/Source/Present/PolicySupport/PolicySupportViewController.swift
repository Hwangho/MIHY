//
//  PolicySupportViewController.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import UIKit

import SnapKit
import RealmSwift


class PolicySupportViewController: BaseViewController {
    
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    
    /// variable
    let viewModel = PolicySupportViewModel()
    
    
    /// Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPolicyData()
    }
    
    override func setupAttributes() {
        super.setupAttributes()
        settingTableView()
        navigationItem.title = "청년 정책"
        
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            showAlertMessage(title: "Document 파일 통로를 못찾았습니다.")
            return
        }
        print("❤️document path ==== \(path)❤️")
        
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setData() {
        viewModel.realmService.featchData()
        viewModel.setdata()
    }
    
    func fetchPolicyData() {
        viewModel.setdata()
        self.tableView.reloadData()
    }

}


// MARK: - DiffableTableView
extension PolicySupportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func settingTableView() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.register(PolicyTableViewViewCell.self, forCellReuseIdentifier: PolicyTableViewViewCell.reuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.policyDataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = viewModel.policyDataArray[section]
        switch data.cellType {
        case .onlyHeader:
            return 0
        case .newPolicy, .oldPolicy:
            return data.data!.count

        }
//        if let policyDataArray = viewModel.policyDataArray[section].data {
//            return policyDataArray.count
//        } else {
//            return 0
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: PolicyTableViewViewCell.reuseIdentifier, for: indexPath) as? PolicyTableViewViewCell else {
            return UITableViewCell()
        }
        
        let type = viewModel.policyDataArray[indexPath.section].cellType
        
        switch type {
        case .onlyHeader:
            return cell
        case .newPolicy, .oldPolicy:
            let data = viewModel.policyDataArray[indexPath.section].data![indexPath.item]
            cell.configure(policyData: data)
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let type = viewModel.policyDataArray[section].cellType
        
        switch type {
        case .onlyHeader:
            let headerView = PolicySupportHeaderView()
            headerView.backgroundColor = .orange
            return headerView
            
        case .newPolicy, .oldPolicy:
            let headerView = PolicySupportScetionHeaderFooterView(type: .header)
            headerView.titleLabel.text = type.title
            return headerView
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let type = viewModel.policyDataArray[section].cellType
        
        switch type {
        case .onlyHeader:
            let footerView = PolicySupportScetionHeaderFooterView(type: .footer)
            footerView.delegate = self
            return footerView
        default:
            return nil
        }
    }

//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//        let type = viewModel.policyDataArray[section].cellType
//        switch type {
//        case .onlyHeader:
//            return 250
//        case .newPolicy, .oldPolicy:
//            return 30
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//
//        let type = viewModel.policyDataArray[section].cellType
//        switch type {
//        case .onlyHeader:
//            return 30
//        default:
//            return 10
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.policyDataArray[indexPath.section].data![indexPath.row]

        viewModel.realmService.updateClickData(data: data)
        
        let vc = PolicySupoortDetailViewController()
        transition(vc, transitionStyle: .push)
    }
    
}


// MARK: - CellDelegate
extension PolicySupportViewController: CellDelegate {
    func swipeCell(indexPath: IndexPath) {
        let data = viewModel.policyDataArray[indexPath.section].data![indexPath.row]

        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
            guard let cell = self.tableView.cellForRow(at: indexPath) as? PolicyTableViewViewCell else{
                return
            }
            cell.contentView.alpha = 0
        }, completion: { _ in self.tableView.performBatchUpdates({
            self.viewModel.realmService.updateHiddenData(data: data)

            // Deleting the row in the tableView
            if self.tableView.numberOfRows(inSection: indexPath.section) > 1 {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                let indexSet = NSMutableIndexSet()
                indexSet.add(indexPath.section)
                self.tableView.deleteSections(indexSet as IndexSet, with: .fade)
            }
            self.fetchPolicyData()
        })})
    }
}





extension PolicySupportViewController: taphiddenButton {
    
    func tapHiddenPolicyButton() {
        let vc = HiddenPolicySupportViewController()
        transition(vc, transitionStyle: .push)
    }
    
    
}
