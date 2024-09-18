//
//  MainView.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/09/06.
//

import Foundation

protocol MainView: class {
    func configureTitle(with title: String)    
    func updateView()
}

class MainViewStub: MainView {
    var configureTitleCalled = false
    
    func configureTitle(with title: String) {
        configureTitleCalled = true
    }
   
    var didCallUpdateView = false
    
    func updateView() {
        didCallUpdateView = true
    }
}
