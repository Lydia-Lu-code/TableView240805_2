import UIKit

class CustomView: UIView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10 // 設置圓角
        imageView.layer.masksToBounds = true // 確保裁剪效果
        imageView.backgroundColor = .systemGray
        return imageView
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping // 以單字為單位折行
        return label
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
        let stackView = UIStackView(arrangedSubviews: [imageView, label1, label2])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 200), // 設置圖片的高度
            imageView.widthAnchor.constraint(equalToConstant: 200 / 6 * 4),   // 設置圖片的寬度
            
            // 確保 stackView 的左右邊緣對齊 imageView 的左右邊緣
            stackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])

    }

    
    func configure(with image: UIImage?, labelText1: String, labelText2: String) {
        imageView.image = image
        label1.text = labelText1
        label2.text = labelText2
        print("Configuring CustomView with \(labelText1) and \(labelText2)")
    }
}
