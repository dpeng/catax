import UIKit

class CatProfileViewController: UIViewController {
    
    // Data
    private let cat: Cat
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let headerView = UIView()
    private let catImageView = UIImageView()
    private let catNameLabel = UILabel()
    private let catDetailsLabel = UILabel()
    private let shareProfileButton = UIButton(type: .system)
    private let segmentedControl = UISegmentedControl(items: ["Overview", "Health Log", "Documents", "Gallery"])
    
    // Container views for different tabs
    private let overviewView = UIView()
    private let healthLogView = UIView()
    private let documentsView = UIView()
    private let galleryView = UIView()
    
    init(cat: Cat) {
        self.cat = cat
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupOverviewContent()
        setupHealthLogContent()
        setupDocumentsContent()
        setupGalleryContent()
        segmentedControlChanged(segmentedControl)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = cat.name
        
        // Setup navigation bar
        navigationItem.largeTitleDisplayMode = .never
        
        // Header view
        headerView.backgroundColor = .systemBackground
        headerView.layer.cornerRadius = 16
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        headerView.layer.shadowRadius = 8
        headerView.layer.shadowOpacity = 0.1
        
        // Cat image view
        catImageView.contentMode = .scaleAspectFill
        catImageView.clipsToBounds = true
        catImageView.layer.cornerRadius = 40
        catImageView.backgroundColor = .systemGray5
        catImageView.image = UIImage(systemName: "photo")
        catImageView.tintColor = .systemGray3
        
        // Cat name label
        catNameLabel.text = cat.name
        catNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        catNameLabel.textColor = .label
        
        // Cat details label
        catDetailsLabel.text = "\(cat.breed) • \(cat.age) years old • Microchip: \(cat.microchipNumber)"
        catDetailsLabel.font = .systemFont(ofSize: 14)
        catDetailsLabel.textColor = .secondaryLabel
        catDetailsLabel.numberOfLines = 0
        
        // Share profile button - THE KEY FEATURE!
        shareProfileButton.setTitle("Share Profile", for: .normal)
        shareProfileButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareProfileButton.backgroundColor = .systemOrange
        shareProfileButton.tintColor = .white
        shareProfileButton.layer.cornerRadius = 8
        shareProfileButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        shareProfileButton.addTarget(self, action: #selector(shareProfileTapped), for: .touchUpInside)
        
        // Segmented control
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        
        // Setup container views
        [overviewView, healthLogView, documentsView, galleryView].forEach { view in
            view.backgroundColor = .systemBackground
            view.layer.cornerRadius = 16
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 2)
            view.layer.shadowRadius = 8
            view.layer.shadowOpacity = 0.1
            view.isHidden = true
        }
        overviewView.isHidden = false
        
        // Add views to hierarchy
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        headerView.addSubview(catImageView)
        headerView.addSubview(catNameLabel)
        headerView.addSubview(catDetailsLabel)
        headerView.addSubview(shareProfileButton)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(overviewView)
        contentView.addSubview(healthLogView)
        contentView.addSubview(documentsView)
        contentView.addSubview(galleryView)
        
        // Setup auto layout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        catImageView.translatesAutoresizingMaskIntoConstraints = false
        catNameLabel.translatesAutoresizingMaskIntoConstraints = false
        catDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        shareProfileButton.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        overviewView.translatesAutoresizingMaskIntoConstraints = false
        healthLogView.translatesAutoresizingMaskIntoConstraints = false
        documentsView.translatesAutoresizingMaskIntoConstraints = false
        galleryView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll view
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Header view
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            headerView.heightAnchor.constraint(equalToConstant: 140),
            
            // Cat image view
            catImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            catImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            catImageView.widthAnchor.constraint(equalToConstant: 80),
            catImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Cat name label
            catNameLabel.topAnchor.constraint(equalTo: catImageView.topAnchor),
            catNameLabel.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 16),
            catNameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
            // Cat details label
            catDetailsLabel.topAnchor.constraint(equalTo: catNameLabel.bottomAnchor, constant: 4),
            catDetailsLabel.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 16),
            catDetailsLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
            // Share profile button
            shareProfileButton.bottomAnchor.constraint(equalTo: catImageView.bottomAnchor),
            shareProfileButton.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 16),
            shareProfileButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            shareProfileButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Segmented control
            segmentedControl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Container views
            overviewView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            overviewView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            overviewView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            overviewView.heightAnchor.constraint(equalToConstant: 400),
            overviewView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            healthLogView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            healthLogView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            healthLogView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            healthLogView.heightAnchor.constraint(equalToConstant: 400),
            healthLogView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            documentsView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            documentsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            documentsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            documentsView.heightAnchor.constraint(equalToConstant: 400),
            documentsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            galleryView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            galleryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            galleryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            galleryView.heightAnchor.constraint(equalToConstant: 400),
            galleryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func shareProfileTapped() {
        let shareOptionsVC = ShareProfileViewController(cat: cat)
        let navController = UINavigationController(rootViewController: shareOptionsVC)
        present(navController, animated: true)
    }
    
    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        // Hide all views
        [overviewView, healthLogView, documentsView, galleryView].forEach { $0.isHidden = true }
        
        // Show selected view
        switch sender.selectedSegmentIndex {
        case 0: overviewView.isHidden = false
        case 1: healthLogView.isHidden = false
        case 2: documentsView.isHidden = false
        case 3: galleryView.isHidden = false
        default: break
        }
    }
    
    private func setupOverviewContent() {
        let titleLabel = UILabel()
        titleLabel.text = "Overview"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .label
        
        let weightChart = UIView()
        weightChart.backgroundColor = .systemGray6
        weightChart.layer.cornerRadius = 8
        
        let weightLabel = UILabel()
        weightLabel.text = "Weight Chart"
        weightLabel.font = .systemFont(ofSize: 16, weight: .medium)
        weightLabel.textColor = .label
        
        let keyInfoLabel = UILabel()
        keyInfoLabel.text = "Key Information"
        keyInfoLabel.font = .systemFont(ofSize: 16, weight: .medium)
        keyInfoLabel.textColor = .label
        
        let infoText = UILabel()
        infoText.text = "• Male, Neutered\n• Indoor Cat\n• Microchip: \(cat.microchipNumber)"
        infoText.font = .systemFont(ofSize: 14)
        infoText.textColor = .secondaryLabel
        infoText.numberOfLines = 0
        
        let remindersLabel = UILabel()
        remindersLabel.text = "Upcoming Reminders"
        remindersLabel.font = .systemFont(ofSize: 16, weight: .medium)
        remindersLabel.textColor = .label
        
        let remindersText = UILabel()
        remindersText.text = "• Next Vet Visit: 15 Nov 2025\n• Flea Treatment Due: 1 Dec 2025"
        remindersText.font = .systemFont(ofSize: 14)
        remindersText.textColor = .systemOrange
        remindersText.numberOfLines = 0
        
        overviewView.addSubview(titleLabel)
        overviewView.addSubview(weightChart)
        weightChart.addSubview(weightLabel)
        overviewView.addSubview(keyInfoLabel)
        overviewView.addSubview(infoText)
        overviewView.addSubview(remindersLabel)
        overviewView.addSubview(remindersText)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        weightChart.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        keyInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoText.translatesAutoresizingMaskIntoConstraints = false
        remindersLabel.translatesAutoresizingMaskIntoConstraints = false
        remindersText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: overviewView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: overviewView.leadingAnchor, constant: 16),
            
            weightChart.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            weightChart.leadingAnchor.constraint(equalTo: overviewView.leadingAnchor, constant: 16),
            weightChart.trailingAnchor.constraint(equalTo: overviewView.trailingAnchor, constant: -16),
            weightChart.heightAnchor.constraint(equalToConstant: 80),
            
            weightLabel.centerXAnchor.constraint(equalTo: weightChart.centerXAnchor),
            weightLabel.centerYAnchor.constraint(equalTo: weightChart.centerYAnchor),
            
            keyInfoLabel.topAnchor.constraint(equalTo: weightChart.bottomAnchor, constant: 20),
            keyInfoLabel.leadingAnchor.constraint(equalTo: overviewView.leadingAnchor, constant: 16),
            
            infoText.topAnchor.constraint(equalTo: keyInfoLabel.bottomAnchor, constant: 8),
            infoText.leadingAnchor.constraint(equalTo: overviewView.leadingAnchor, constant: 16),
            infoText.trailingAnchor.constraint(equalTo: overviewView.trailingAnchor, constant: -16),
            
            remindersLabel.topAnchor.constraint(equalTo: infoText.bottomAnchor, constant: 20),
            remindersLabel.leadingAnchor.constraint(equalTo: overviewView.leadingAnchor, constant: 16),
            
            remindersText.topAnchor.constraint(equalTo: remindersLabel.bottomAnchor, constant: 8),
            remindersText.leadingAnchor.constraint(equalTo: overviewView.leadingAnchor, constant: 16),
            remindersText.trailingAnchor.constraint(equalTo: overviewView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupHealthLogContent() {
        let titleLabel = UILabel()
        titleLabel.text = "Health Log"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .label
        
        let scrollView = UIScrollView()
        let logContainer = UIView()
        
        let sampleLogs = [
            "Nov 1, 14:00: 💊 Gave Flea Medication",
            "Nov 1, 09:00: 🤮 Vomited (Hairball)",
            "Nov 1, 08:00: 🍽️ Fed 1/2 can of (Brand)",
            "Oct 30: 💩 Normal litter box",
            "Oct 29: 🏥 Vet checkup - All good!"
        ]
        
        var previousLabel: UILabel?
        
        for (index, log) in sampleLogs.enumerated() {
            let logLabel = UILabel()
            logLabel.text = log
            logLabel.font = .systemFont(ofSize: 14)
            logLabel.textColor = .label
            logLabel.backgroundColor = .systemGray6
            logLabel.layer.cornerRadius = 8
            logLabel.layer.masksToBounds = true
            logLabel.textAlignment = .left
            logLabel.numberOfLines = 0
            
            // Add padding
            logLabel.text = "  \(log)  "
            
            logContainer.addSubview(logLabel)
            logLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                logLabel.leadingAnchor.constraint(equalTo: logContainer.leadingAnchor, constant: 16),
                logLabel.trailingAnchor.constraint(equalTo: logContainer.trailingAnchor, constant: -16),
                logLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            if let previous = previousLabel {
                logLabel.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 8).isActive = true
            } else {
                logLabel.topAnchor.constraint(equalTo: logContainer.topAnchor, constant: 16).isActive = true
            }
            
            if index == sampleLogs.count - 1 {
                logLabel.bottomAnchor.constraint(equalTo: logContainer.bottomAnchor, constant: -16).isActive = true
            }
            
            previousLabel = logLabel
        }
        
        healthLogView.addSubview(titleLabel)
        healthLogView.addSubview(scrollView)
        scrollView.addSubview(logContainer)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        logContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: healthLogView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: healthLogView.leadingAnchor, constant: 16),
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: healthLogView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: healthLogView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: healthLogView.bottomAnchor, constant: -16),
            
            logContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            logContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            logContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            logContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            logContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupDocumentsContent() {
        let titleLabel = UILabel()
        titleLabel.text = "Documents"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .label
        
        let documents = [
            ("Vaccine Records", "📁", "2 files"),
            ("Vet Visits & Bills", "📁", "5 files"),
            ("Insurance", "📁", "1 file"),
            ("Notes", "📁", "3 files")
        ]
        
        var previousView: UIView?
        
        for (index, document) in documents.enumerated() {
            let docView = UIView()
            docView.backgroundColor = .systemGray6
            docView.layer.cornerRadius = 8
            
            let iconLabel = UILabel()
            iconLabel.text = document.1
            iconLabel.font = .systemFont(ofSize: 24)
            
            let nameLabel = UILabel()
            nameLabel.text = document.0
            nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
            nameLabel.textColor = .label
            
            let countLabel = UILabel()
            countLabel.text = document.2
            countLabel.font = .systemFont(ofSize: 12)
            countLabel.textColor = .secondaryLabel
            
            let chevronLabel = UILabel()
            chevronLabel.text = ">"
            chevronLabel.font = .systemFont(ofSize: 16, weight: .medium)
            chevronLabel.textColor = .systemGray
            
            docView.addSubview(iconLabel)
            docView.addSubview(nameLabel)
            docView.addSubview(countLabel)
            docView.addSubview(chevronLabel)
            documentsView.addSubview(docView)
            
            docView.translatesAutoresizingMaskIntoConstraints = false
            iconLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            chevronLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                docView.leadingAnchor.constraint(equalTo: documentsView.leadingAnchor, constant: 16),
                docView.trailingAnchor.constraint(equalTo: documentsView.trailingAnchor, constant: -16),
                docView.heightAnchor.constraint(equalToConstant: 60),
                
                iconLabel.leadingAnchor.constraint(equalTo: docView.leadingAnchor, constant: 16),
                iconLabel.centerYAnchor.constraint(equalTo: docView.centerYAnchor),
                
                nameLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 12),
                nameLabel.topAnchor.constraint(equalTo: docView.topAnchor, constant: 12),
                
                countLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 12),
                countLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
                
                chevronLabel.trailingAnchor.constraint(equalTo: docView.trailingAnchor, constant: -16),
                chevronLabel.centerYAnchor.constraint(equalTo: docView.centerYAnchor)
            ])
            
            if index == 0 {
                docView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
            } else if let previous = previousView {
                docView.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 12).isActive = true
            }
            
            previousView = docView
        }
        
        documentsView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: documentsView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: documentsView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupGalleryContent() {
        let titleLabel = UILabel()
        titleLabel.text = "Photo Gallery"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .label
        
        let placeholderView = UIView()
        placeholderView.backgroundColor = .systemGray6
        placeholderView.layer.cornerRadius = 8
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = "📸\n\nRecent Cat Tax photos will appear here"
        placeholderLabel.font = .systemFont(ofSize: 16)
        placeholderLabel.textColor = .secondaryLabel
        placeholderLabel.textAlignment = .center
        placeholderLabel.numberOfLines = 0
        
        galleryView.addSubview(titleLabel)
        galleryView.addSubview(placeholderView)
        placeholderView.addSubview(placeholderLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: galleryView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: galleryView.leadingAnchor, constant: 16),
            
            placeholderView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            placeholderView.leadingAnchor.constraint(equalTo: galleryView.leadingAnchor, constant: 16),
            placeholderView.trailingAnchor.constraint(equalTo: galleryView.trailingAnchor, constant: -16),
            placeholderView.heightAnchor.constraint(equalToConstant: 200),
            
            placeholderLabel.centerXAnchor.constraint(equalTo: placeholderView.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: placeholderView.centerYAnchor)
        ])
    }
}