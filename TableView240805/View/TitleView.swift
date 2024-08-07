//
//  titleView.swift
//  TableView240805
//
//  Created by Lydia Lu on 2024/8/5.
//

import UIKit

class TitleView: UIView {

    let title: UILabel = {
        let title = UILabel()
        title.text = "\n\nMovies" // 增加三个换行符
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.numberOfLines = 0 // 允许多行
        title.lineBreakMode = .byWordWrapping // 自动换行
        title.font = UIFont.systemFont(ofSize: 24) // 设置文字大小为16
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

