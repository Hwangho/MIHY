//
//  Observable.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import Foundation


class Observable<T> {
    
    private var listener: ((T) -> Void)?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init (_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
