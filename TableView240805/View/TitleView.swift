//
//  titleView.swift
//  TableView240805
//
//  Created by Lydia Lu on 2024/8/5.
//

import UIKit

class TitleView: UIView {

    let title: UILabel = {
        var title = UILabel()
        title.text = "Movies"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        
    }
    
    private func setupView() {
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

