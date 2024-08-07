import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var titleView = TitleView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemYellow
        return collectionView
    }()
    
    private let viewModel = MoviesViewModel()
    private let movieTypes: [MovieType] = [.action, .comedy, .drama, .horror, .sciFi]
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let customStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .systemGreen
        return stackView
    }()
    
    private var selectedMovieType: MovieType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        titleView.backgroundColor = UIColor.systemPink
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        // 設定預設的電影類型為 .action
        selectedMovieType = .action
        setupCustomViews() // 更新顯示電影資料
    }
    
    func setupCustomViews() {
        customStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let selectedType = selectedMovieType else {
            let defaultView = CustomView()
            defaultView.translatesAutoresizingMaskIntoConstraints = false
            defaultView.configure(
                with: UIImage(named: "placeholder.png"),
                labelText1: "無資料",
                labelText2: "請選擇電影類型"
            )
            customStackView.addArrangedSubview(defaultView)
            return
        }
        
        let moviesForType = viewModel.movies(for: selectedType)
        
        if moviesForType.isEmpty {
            let defaultView = CustomView()
            defaultView.translatesAutoresizingMaskIntoConstraints = false
            defaultView.configure(
                with: UIImage(named: "placeholder.png"),
                labelText1: "\(selectedType.rawValue)",
                labelText2: "無資料"
            )
            customStackView.addArrangedSubview(defaultView)
        } else {
            for movie in moviesForType {
                let customView = CustomView()
                customView.translatesAutoresizingMaskIntoConstraints = false
                customView.configure(
                    with: UIImage(named: "\(movie.title).png"),
                    labelText1: "\(selectedType.rawValue)",
                    labelText2: movie.title
                )
                customStackView.addArrangedSubview(customView)
            }
        }
        print("setupCustomViews called")
    }
    
    func updateMovies(for type: MovieType) {
        let movies = viewModel.movies(for: type)
        customStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if movies.isEmpty {
            let defaultView = CustomView()
            defaultView.translatesAutoresizingMaskIntoConstraints = false
            defaultView.configure(
                with: UIImage(named: "placeholder.png"),
                labelText1: "\(type.rawValue)",
                labelText2: "無資料"
            )
            customStackView.addArrangedSubview(defaultView)
        } else {
            for movie in movies {
                let customView = CustomView()
                customView.translatesAutoresizingMaskIntoConstraints = false
                customView.configure(
                    with: UIImage(named: "\(movie.title).png"),
                    labelText1: "\(type.rawValue)",
                    labelText2: movie.title
                )
                customStackView.addArrangedSubview(customView)
            }
        }
        
        // 確保 scrollView 回到最左邊
        DispatchQueue.main.async {
            let contentOffset = CGPoint(x: -self.scrollView.contentInset.left, y: 0)
            self.scrollView.setContentOffset(contentOffset, animated: false)
        }
    }

    func setLayout() {
        view.addSubview(titleView)
        view.addSubview(collectionView)
        view.addSubview(scrollView)
        scrollView.addSubview(customStackView)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        customStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 60),
            
            collectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            
            scrollView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            customStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            customStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            customStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            customStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            customStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
        cell.configure(with: movieTypes) { [weak self] movieType in
            self?.selectedMovieType = movieType
            self?.updateMovies(for: movieType)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60)
    }
}

