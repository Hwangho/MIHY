//
//  HiddenPolicySupportViewController.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/27.
//

import UIKit

import SnapKit
import RealmSwift


class HiddenPolicySupportViewController: BaseViewController {
    
    /// UI
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    
    /// variable
    let viewModel = HiddenPolicySupportViewModel()
    
    
    /// Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPolicyData()
    }
    
    override func setupAttributes() {
        super.setupAttributes()
        settingTableView()
        navigationItem.title = "숨김 정책"
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
    
    
    /// Custom Func
    func fetchPolicyData() {
        viewModel.setdata()
        self.tableView.reloadData()
    }
}


// MARK: - DiffableTableView
extension HiddenPolicySupportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func settingTableView() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.separatorStyle = .none
        tableView.register(PolicyTableViewViewCell.self, forCellReuseIdentifier: PolicyTableViewViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.policyDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: PolicyTableViewViewCell.reuseIdentifier, for: indexPath) as? PolicyTableViewViewCell else {
            return UITableViewCell()
        }
        
        let data = viewModel.policyDataArray[indexPath.item]
        cell.configure(policyData: data)
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.policyDataArray[indexPath.item]
        viewModel.realmService.updateClickData(data: data)
        
        let vc = PolicySupoortDetailViewController(policyid: data.policyID)
        transition(vc, transitionStyle: .push)
    }
    
}


// MARK: - CellDelegate
extension HiddenPolicySupportViewController: CellDelegate {

    func swipeCell(indexPath: IndexPath) {
        let data = viewModel.policyDataArray[indexPath.item]

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

