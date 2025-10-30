import UIKit

class ShareProfileViewController: UIViewController {
    
    // Data
    private let cat: Cat
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    // Share option buttons
    private let coOwnerButton = UIButton(type: .system)
    private let shareableLinkButton = UIButton(type: .system)
    
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
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Share \(cat.name)'s Profile"
        
        // Navigation bar setup
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        
        // Title label
        titleLabel.text = "How would you like to share?"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        
        // Subtitle label
        subtitleLabel.text = "Choose the best way to share \(cat.name)'s information"
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        
        // Co-owner button
        setupCoOwnerButton()
        
        // Shareable link button
        setupShareableLinkButton()
        
        // Add views to hierarchy
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(coOwnerButton)
        contentView.addSubview(shareableLinkButton)
        
        // Setup auto layout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        coOwnerButton.translatesAutoresizingMaskIntoConstraints = false
        shareableLinkButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupCoOwnerButton() {
        coOwnerButton.backgroundColor = .systemBlue
        coOwnerButton.layer.cornerRadius = 16
        coOwnerButton.addTarget(self, action: #selector(coOwnerTapped), for: .touchUpInside)
        
        let iconLabel = UILabel()
        iconLabel.text = "👥"
        iconLabel.font = .systemFont(ofSize: 32)
        
        let titleLabel = UILabel()
        titleLabel.text = "Invite a Co-Owner"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "For family or partners who share care.\nFull access to add logs, photos, and view everything."
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .white.withAlphaComponent(0.9)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        coOwnerButton.addSubview(iconLabel)
        coOwnerButton.addSubview(titleLabel)
        coOwnerButton.addSubview(descriptionLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconLabel.topAnchor.constraint(equalTo: coOwnerButton.topAnchor, constant: 20),
            iconLabel.centerXAnchor.constraint(equalTo: coOwnerButton.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: coOwnerButton.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: coOwnerButton.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: coOwnerButton.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: coOwnerButton.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupShareableLinkButton() {
        shareableLinkButton.backgroundColor = .systemOrange
        shareableLinkButton.layer.cornerRadius = 16
        shareableLinkButton.addTarget(self, action: #selector(shareableLinkTapped), for: .touchUpInside)
        
        let iconLabel = UILabel()
        iconLabel.text = "🔗"
        iconLabel.font = .systemFont(ofSize: 32)
        
        let titleLabel = UILabel()
        titleLabel.text = "Generate Shareable Link"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "For vets, sitters, or friends (View-only).\nChoose what to share and set duration."
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .white.withAlphaComponent(0.9)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        let highlightLabel = UILabel()
        highlightLabel.text = "🌟 Perfect for new vets in Portugal!"
        highlightLabel.font = .systemFont(ofSize: 12, weight: .medium)
        highlightLabel.textColor = .white
        highlightLabel.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        highlightLabel.layer.cornerRadius = 8
        highlightLabel.layer.masksToBounds = true
        highlightLabel.textAlignment = .center
        
        shareableLinkButton.addSubview(iconLabel)
        shareableLinkButton.addSubview(titleLabel)
        shareableLinkButton.addSubview(descriptionLabel)
        shareableLinkButton.addSubview(highlightLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        highlightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconLabel.topAnchor.constraint(equalTo: shareableLinkButton.topAnchor, constant: 20),
            iconLabel.centerXAnchor.constraint(equalTo: shareableLinkButton.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: shareableLinkButton.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: shareableLinkButton.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: shareableLinkButton.trailingAnchor, constant: -16),
            
            highlightLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            highlightLabel.centerXAnchor.constraint(equalTo: shareableLinkButton.centerXAnchor),
            highlightLabel.heightAnchor.constraint(equalToConstant: 28),
            highlightLabel.widthAnchor.constraint(equalToConstant: 220),
            highlightLabel.bottomAnchor.constraint(equalTo: shareableLinkButton.bottomAnchor, constant: -20)
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
            
            // Co-owner button
            coOwnerButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            coOwnerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            coOwnerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // Shareable link button
            shareableLinkButton.topAnchor.constraint(equalTo: coOwnerButton.bottomAnchor, constant: 24),
            shareableLinkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            shareableLinkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            shareableLinkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func coOwnerTapped() {
        let alertController = UIAlertController(
            title: "Invite Co-Owner",
            message: "Enter the email address of the person you'd like to invite as a co-owner for \(cat.name).",
            preferredStyle: .alert
        )
        
        alertController.addTextField { textField in
            textField.placeholder = "email@example.com"
            textField.keyboardType = .emailAddress
        }
        
        let sendAction = UIAlertAction(title: "Send Invite", style: .default) { _ in
            if let email = alertController.textFields?.first?.text, !email.isEmpty {
                self.sendCoOwnerInvite(email: email)
            }
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(sendAction)
        
        present(alertController, animated: true)
    }
    
    @objc private func shareableLinkTapped() {
        let linkOptionsVC = ShareableLinkOptionsViewController(cat: cat)
        navigationController?.pushViewController(linkOptionsVC, animated: true)
    }
    
    private func sendCoOwnerInvite(email: String) {
        let successAlert = UIAlertController(
            title: "Invite Sent! 📧",
            message: "We've sent an invitation to \(email) to become a co-owner of \(cat.name)'s profile.",
            preferredStyle: .alert
        )
        
        successAlert.addAction(UIAlertAction(title: "Done", style: .default) { _ in
            self.dismiss(animated: true)
        })
        
        present(successAlert, animated: true)
    }
}