import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10 // 按鈕間距
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private var buttonAction: ((MovieType) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            buttonStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            buttonStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            buttonStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    func configure(with movieTypes: [MovieType], buttonAction: @escaping (MovieType) -> Void) {
        self.buttonAction = buttonAction
        buttonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for movieType in movieTypes {
            let button = UIButton()
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 5
            button.setTitle(movieType.rawValue, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 70).isActive = true
            button.heightAnchor.constraint(equalToConstant: 35).isActive = true
            buttonStackView.addArrangedSubview(button)
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text, let movieType = MovieType(rawValue: title) else {
            return
        }
        buttonAction?(movieType)
        // 假設這裡有一個方法來滾動到 UICollectionView 的預設位置
    }
    

}
