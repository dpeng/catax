import UIKit

class CareViewController: UIViewController {
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupContent()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Care"
        
        // Setup navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        // Add views
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Setup auto layout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
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
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupContent() {
        let titleLabel = UILabel()
        titleLabel.text = "Cat Care Resources 🏥"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Health tips, reminders, and care information"
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        
        // Care sections
        let sections = [
            ("🏥", "Find Local Vets", "Discover veterinarians in your area"),
            ("💊", "Medication Reminders", "Never miss a dose or treatment"),
            ("📅", "Appointment Scheduling", "Keep track of vet visits"),
            ("📚", "Care Articles", "Learn about cat health and wellness"),
            ("🆘", "Emergency Contacts", "Quick access to emergency vets"),
            ("📊", "Health Insights", "Track your cat's health trends")
        ]
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var previousView: UIView = subtitleLabel
        
        for (icon, title, description) in sections {
            let sectionView = createCareSection(icon: icon, title: title, description: description)
            contentView.addSubview(sectionView)
            sectionView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                sectionView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 16),
                sectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                sectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                sectionView.heightAnchor.constraint(equalToConstant: 80)
            ])
            
            previousView = sectionView
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            previousView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func createCareSection(icon: String, title: String, description: String) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.1
        
        let iconLabel = UILabel()
        iconLabel.text = icon
        iconLabel.font = .systemFont(ofSize: 28)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .label
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        
        let chevronLabel = UILabel()
        chevronLabel.text = ">"
        chevronLabel.font = .systemFont(ofSize: 16, weight: .medium)
        chevronLabel.textColor = .systemGray
        
        containerView.addSubview(iconLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(chevronLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: chevronLabel.leadingAnchor, constant: -16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: chevronLabel.leadingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            chevronLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            chevronLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        // Add tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(careSectionTapped))
        containerView.addGestureRecognizer(tapGesture)
        containerView.isUserInteractionEnabled = true
        
        return containerView
    }
    
    @objc private func careSectionTapped() {
        let alert = UIAlertController(
            title: "Care Feature",
            message: "This feature would provide detailed care information and tools for cat health management.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Got it!", style: .default))
        present(alert, animated: true)
    }
}