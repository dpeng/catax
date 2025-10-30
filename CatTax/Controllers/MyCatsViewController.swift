import UIKit

class MyCatsViewController: UIViewController {
    
    // UI Elements
    private let collectionView: UICollectionView
    private let addCatButton = UIButton(type: .system)
    
    // Sample data
    private var cats: [Cat] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 200)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadSampleData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "My Cats"
        
        // Setup navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        // Add cat button in navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addCatTapped)
        )
        
        // Setup collection view
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CatCollectionViewCell.self, forCellWithReuseIdentifier: "CatCell")
        collectionView.showsVerticalScrollIndicator = false
        
        // Add views
        view.addSubview(collectionView)
        
        // Setup auto layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadSampleData() {
        cats = [
            Cat(name: "Simba", breed: "Maine Coon", age: 3, imageName: "cat1", microchipNumber: "123456789012345"),
            Cat(name: "Luna", breed: "British Shorthair", age: 2, imageName: "cat2", microchipNumber: "123456789012346"),
            Cat(name: "Milo", breed: "Persian", age: 5, imageName: "cat3", microchipNumber: "123456789012347")
        ]
        collectionView.reloadData()
    }
    
    @objc private func addCatTapped() {
        let alertController = UIAlertController(
            title: "Add New Cat",
            message: "This feature will allow you to add a new cat profile with all their information.",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension MyCatsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath) as! CatCollectionViewCell
        cell.configure(with: cats[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cat = cats[indexPath.item]
        let catProfileVC = CatProfileViewController(cat: cat)
        navigationController?.pushViewController(catProfileVC, animated: true)
    }
}

// MARK: - Data Models
struct Cat {
    let name: String
    let breed: String
    let age: Int
    let imageName: String
    let microchipNumber: String
    var weight: Double = 0.0
    var isNeutered: Bool = true
    var isIndoor: Bool = true
}

// MARK: - CatCollectionViewCell (Temporary inline definition)
class CatCollectionViewCell: UICollectionViewCell {
    
    // UI Elements
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let breedLabel = UILabel()
    private let ageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.1
        
        // Image view
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .systemGray5
        
        // Name label
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .center
        
        // Breed label
        breedLabel.font = .systemFont(ofSize: 12)
        breedLabel.textColor = .secondaryLabel
        breedLabel.textAlignment = .center
        breedLabel.numberOfLines = 1
        
        // Age label
        ageLabel.font = .systemFont(ofSize: 12)
        ageLabel.textColor = .systemOrange
        ageLabel.textAlignment = .center
        
        // Add subviews
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(breedLabel)
        addSubview(ageLabel)
        
        // Setup auto layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        breedLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Image view
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Name label
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            // Breed label
            breedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            breedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            breedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            // Age label
            ageLabel.topAnchor.constraint(equalTo: breedLabel.bottomAnchor, constant: 2),
            ageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            ageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            ageLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with cat: Cat) {
        nameLabel.text = cat.name
        breedLabel.text = cat.breed
        ageLabel.text = "\(cat.age) year\(cat.age == 1 ? "" : "s") old"
        
        // Set placeholder image (in a real app, you'd load the actual image)
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .systemGray3
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        breedLabel.text = nil
        ageLabel.text = nil
    }
}