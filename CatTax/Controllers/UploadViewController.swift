import UIKit

class UploadViewController: UIViewController {
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    // Action buttons
    private let catTaxButton = UIButton(type: .system)
    private let logEventButton = UIButton(type: .system)
    private let addDocumentButton = UIButton(type: .system)
    private let logWeightButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Cat Tax Station"
        
        // Setup navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        // Title label
        titleLabel.text = "Time to Pay Your Cat Tax! 🐱"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        // Subtitle label
        subtitleLabel.text = "Upload photos, log events, or add documents for your cats"
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        
        // Setup action buttons
        setupCatTaxButton()
        setupLogEventButton()
        setupAddDocumentButton()
        setupLogWeightButton()
        
        // Add views to hierarchy
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(catTaxButton)
        contentView.addSubview(logEventButton)
        contentView.addSubview(addDocumentButton)
        contentView.addSubview(logWeightButton)
        
        // Setup auto layout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        catTaxButton.translatesAutoresizingMaskIntoConstraints = false
        logEventButton.translatesAutoresizingMaskIntoConstraints = false
        addDocumentButton.translatesAutoresizingMaskIntoConstraints = false
        logWeightButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupCatTaxButton() {
        catTaxButton.backgroundColor = .systemOrange
        catTaxButton.layer.cornerRadius = 16
        catTaxButton.addTarget(self, action: #selector(catTaxTapped), for: .touchUpInside)
        
        let iconLabel = UILabel()
        iconLabel.text = "📸"
        iconLabel.font = .systemFont(ofSize: 40)
        
        let titleLabel = UILabel()
        titleLabel.text = "Pay Your Cat Tax!"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .white
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Upload a photo for AI scoring and sharing"
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .white.withAlphaComponent(0.9)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        catTaxButton.addSubview(iconLabel)
        catTaxButton.addSubview(titleLabel)
        catTaxButton.addSubview(descriptionLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconLabel.topAnchor.constraint(equalTo: catTaxButton.topAnchor, constant: 20),
            iconLabel.centerXAnchor.constraint(equalTo: catTaxButton.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: catTaxButton.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: catTaxButton.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: catTaxButton.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: catTaxButton.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupLogEventButton() {
        logEventButton.backgroundColor = .systemBlue
        logEventButton.layer.cornerRadius = 12
        logEventButton.addTarget(self, action: #selector(logEventTapped), for: .touchUpInside)
        
        let iconLabel = UILabel()
        iconLabel.text = "📝"
        iconLabel.font = .systemFont(ofSize: 24)
        
        let titleLabel = UILabel()
        titleLabel.text = "Log an Event"
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Food, meds, vet visit, etc."
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .white.withAlphaComponent(0.9)
        
        logEventButton.addSubview(iconLabel)
        logEventButton.addSubview(titleLabel)
        logEventButton.addSubview(descriptionLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: logEventButton.leadingAnchor, constant: 16),
            iconLabel.centerYAnchor.constraint(equalTo: logEventButton.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: logEventButton.topAnchor, constant: 12),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 12),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            descriptionLabel.bottomAnchor.constraint(equalTo: logEventButton.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupAddDocumentButton() {
        addDocumentButton.backgroundColor = .systemGreen
        addDocumentButton.layer.cornerRadius = 12
        addDocumentButton.addTarget(self, action: #selector(addDocumentTapped), for: .touchUpInside)
        
        let iconLabel = UILabel()
        iconLabel.text = "📄"
        iconLabel.font = .systemFont(ofSize: 24)
        
        let titleLabel = UILabel()
        titleLabel.text = "Add a Document"
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Scan or upload files"
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .white.withAlphaComponent(0.9)
        
        addDocumentButton.addSubview(iconLabel)
        addDocumentButton.addSubview(titleLabel)
        addDocumentButton.addSubview(descriptionLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: addDocumentButton.leadingAnchor, constant: 16),
            iconLabel.centerYAnchor.constraint(equalTo: addDocumentButton.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: addDocumentButton.topAnchor, constant: 12),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 12),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            descriptionLabel.bottomAnchor.constraint(equalTo: addDocumentButton.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupLogWeightButton() {
        logWeightButton.backgroundColor = .systemPurple
        logWeightButton.layer.cornerRadius = 12
        logWeightButton.addTarget(self, action: #selector(logWeightTapped), for: .touchUpInside)
        
        let iconLabel = UILabel()
        iconLabel.text = "⚖️"
        iconLabel.font = .systemFont(ofSize: 24)
        
        let titleLabel = UILabel()
        titleLabel.text = "Log Weight"
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Quick weight entry"
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .white.withAlphaComponent(0.9)
        
        logWeightButton.addSubview(iconLabel)
        logWeightButton.addSubview(titleLabel)
        logWeightButton.addSubview(descriptionLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: logWeightButton.leadingAnchor, constant: 16),
            iconLabel.centerYAnchor.constraint(equalTo: logWeightButton.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: logWeightButton.topAnchor, constant: 12),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 12),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            descriptionLabel.bottomAnchor.constraint(equalTo: logWeightButton.bottomAnchor, constant: -12)
        ])
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
            
            // Title label
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // Subtitle label
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // Cat tax button (main action)
            catTaxButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            catTaxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            catTaxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            catTaxButton.heightAnchor.constraint(equalToConstant: 160),
            
            // Log event button
            logEventButton.topAnchor.constraint(equalTo: catTaxButton.bottomAnchor, constant: 20),
            logEventButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            logEventButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            logEventButton.heightAnchor.constraint(equalToConstant: 70),
            
            // Add document button
            addDocumentButton.topAnchor.constraint(equalTo: logEventButton.bottomAnchor, constant: 16),
            addDocumentButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            addDocumentButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            addDocumentButton.heightAnchor.constraint(equalToConstant: 70),
            
            // Log weight button
            logWeightButton.topAnchor.constraint(equalTo: addDocumentButton.bottomAnchor, constant: 16),
            logWeightButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            logWeightButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            logWeightButton.heightAnchor.constraint(equalToConstant: 70),
            logWeightButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    @objc private func catTaxTapped() {
        let photoUploadVC = PhotoUploadViewController()
        let navController = UINavigationController(rootViewController: photoUploadVC)
        present(navController, animated: true)
    }
    
    @objc private func logEventTapped() {
        let actionSheet = UIAlertController(title: "Log an Event", message: "What would you like to log?", preferredStyle: .actionSheet)
        
        let events = [
            ("🍽️", "Fed"),
            ("💊", "Medication"),
            ("🤮", "Vomited"),
            ("💩", "Litter Box"),
            ("🏥", "Vet Visit"),
            ("🎾", "Played"),
            ("😴", "Nap Time")
        ]
        
        for (icon, title) in events {
            actionSheet.addAction(UIAlertAction(title: "\(icon) \(title)", style: .default) { _ in
                self.showEventLoggingAlert(for: title)
            })
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = actionSheet.popoverPresentationController {
            popover.sourceView = logEventButton
            popover.sourceRect = logEventButton.bounds
        }
        
        present(actionSheet, animated: true)
    }
    
    @objc private func addDocumentTapped() {
        let actionSheet = UIAlertController(title: "Add Document", message: "How would you like to add a document?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "📷 Scan with Camera", style: .default) { _ in
            self.showDocumentAlert(method: "Camera Scan")
        })
        
        actionSheet.addAction(UIAlertAction(title: "📱 Photo Library", style: .default) { _ in
            self.showDocumentAlert(method: "Photo Library")
        })
        
        actionSheet.addAction(UIAlertAction(title: "📁 Files App", style: .default) { _ in
            self.showDocumentAlert(method: "Files App")
        })
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = actionSheet.popoverPresentationController {
            popover.sourceView = addDocumentButton
            popover.sourceRect = addDocumentButton.bounds
        }
        
        present(actionSheet, animated: true)
    }
    
    @objc private func logWeightTapped() {
        let alert = UIAlertController(title: "Log Weight", message: "Enter your cat's weight", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Weight (lbs or kg)"
            textField.keyboardType = .decimalPad
        }
        
        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                let successAlert = UIAlertController(
                    title: "Weight Logged! ⚖️",
                    message: "Recorded weight: \(text)",
                    preferredStyle: .alert
                )
                successAlert.addAction(UIAlertAction(title: "Done", style: .default))
                self.present(successAlert, animated: true)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showEventLoggingAlert(for event: String) {
        let alert = UIAlertController(
            title: "\(event) Event Logged!",
            message: "This event has been added to your cat's health log.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Done", style: .default))
        present(alert, animated: true)
    }
    
    private func showDocumentAlert(method: String) {
        let alert = UIAlertController(
            title: "Document Upload",
            message: "In a full implementation, this would open the \(method) to add documents to your cat's file cabinet.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Done", style: .default))
        present(alert, animated: true)
    }
}