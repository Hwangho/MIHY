//
//  PolicySupportViewController.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import UIKit


class PolicySupportViewController: BaseViewController {
    

    let viewModel = PolicySupportViewModel()
    
    
    override func setupAttributes() {
        super.setupAttributes()
        view.backgroundColor = .orange
    }
    
    override func setData() {
        server()
    }
    
    func server() {
        viewModel.setdata()
    }
    
}
