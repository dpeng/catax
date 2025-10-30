import UIKit

class ShareableLinkOptionsViewController: UIViewController {
    
    // Data
    private let cat: Cat
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // Information selection switches
    private var informationSwitches: [String: UISwitch] = [:]
    
    // Duration selection
    private let durationSegmentedControl = UISegmentedControl(items: ["24 Hours", "1 Week", "Permanent"])
    
    // Language selection
    private let languageSegmentedControl = UISegmentedControl(items: ["English", "Portuguese", "Auto-detect"])
    
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
        title = "Shareable Link Options"
        
        // Navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Generate Link",
            style: .done,
            target: self,
            action: #selector(generateLinkTapped)
        )
        
        // Setup sections
        setupInformationSection()
        setupDurationSection()
        setupLanguageSection()
    }
    
    private func setupInformationSection() {
        let sectionLabel = createSectionLabel(title: "Select Information to Include")
        contentView.addSubview(sectionLabel)
        
        let informationOptions = [
            ("Basic Info", "Name, Breed, Age", true),
            ("Vaccine & Health Documents", "Vaccination records, health certificates", true),
            ("Medication List", "Current medications and dosages", true),
            ("Health Log", "Daily health events and notes", false),
            ("Photo Gallery", "Recent cat photos", false),
            ("Vet Bills", "Private financial information", false)
        ]
        
        var previousView: UIView = sectionLabel
        
        for (title, description, defaultValue) in informationOptions {
            let optionView = createInformationOptionView(
                title: title,
                description: description,
                defaultValue: defaultValue
            )
            
            contentView.addSubview(optionView)
            optionView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                optionView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 16),
                optionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                optionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                optionView.heightAnchor.constraint(equalToConstant: 70)
            ])
            
            previousView = optionView
        }
    }
    
    private func setupDurationSection() {
        let sectionLabel = createSectionLabel(title: "Link Duration")
        contentView.addSubview(sectionLabel)
        
        durationSegmentedControl.selectedSegmentIndex = 1 // Default to 1 week
        contentView.addSubview(durationSegmentedControl)
        durationSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for section label and segmented control later in setupConstraints
    }
    
    private func setupLanguageSection() {
        let sectionLabel = createSectionLabel(title: "Language")
        contentView.addSubview(sectionLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Auto-translate content for international vets"
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        
        languageSegmentedControl.selectedSegmentIndex = 1 // Default to Portuguese
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(languageSegmentedControl)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        languageSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints later in setupConstraints
    }
    
    private func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Find views for constraint setup
        let informationSectionLabel = contentView.subviews.first { $0 is UILabel && ($0 as! UILabel).text == "Select Information to Include" }!
        let durationSectionLabel = contentView.subviews.first { $0 is UILabel && ($0 as! UILabel).text == "Link Duration" }!
        let languageSectionLabel = contentView.subviews.first { $0 is UILabel && ($0 as! UILabel).text == "Language" }!
        let languageDescriptionLabel = contentView.subviews.first { $0 is UILabel && ($0 as! UILabel).text == "Auto-translate content for international vets" }!
        
        // Find the last information option view
        let informationViews = contentView.subviews.filter { $0.backgroundColor == .systemGray6 }
        let lastInformationView = informationViews.last!
        
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
            
            // Information section
            informationSectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            informationSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // Duration section
            durationSectionLabel.topAnchor.constraint(equalTo: lastInformationView.bottomAnchor, constant: 32),
            durationSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            durationSegmentedControl.topAnchor.constraint(equalTo: durationSectionLabel.bottomAnchor, constant: 16),
            durationSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            durationSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Language section
            languageSectionLabel.topAnchor.constraint(equalTo: durationSegmentedControl.bottomAnchor, constant: 32),
            languageSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            languageDescriptionLabel.topAnchor.constraint(equalTo: languageSectionLabel.bottomAnchor, constant: 8),
            languageDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            languageDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            languageSegmentedControl.topAnchor.constraint(equalTo: languageDescriptionLabel.bottomAnchor, constant: 16),
            languageSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            languageSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            languageSegmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func createSectionLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createInformationOptionView(title: String, description: String, defaultValue: Bool) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 12
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .label
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = defaultValue
        toggleSwitch.onTintColor = .systemOrange
        informationSwitches[title] = toggleSwitch
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(toggleSwitch)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: toggleSwitch.leadingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: toggleSwitch.leadingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            toggleSwitch.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            toggleSwitch.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        
        return containerView
    }
    
    @objc private func generateLinkTapped() {
        // Get selected options
        var selectedInfo: [String] = []
        for (key, toggle) in informationSwitches {
            if toggle.isOn {
                selectedInfo.append(key)
            }
        }
        
        let duration = ["24 Hours", "1 Week", "Permanent"][durationSegmentedControl.selectedSegmentIndex]
        let language = ["English", "Portuguese", "Auto-detect"][languageSegmentedControl.selectedSegmentIndex]
        
        // Generate mock URL
        let mockURL = "https://cattax.app/\(cat.name.lowercased())-\(UUID().uuidString.prefix(8))"
        
        // Show success with the generated link
        let successAlert = UIAlertController(
            title: "Link Generated! 🔗",
            message: "Your shareable link is ready:\n\n\(mockURL)\n\nDuration: \(duration)\nLanguage: \(language)\nIncludes: \(selectedInfo.joined(separator: ", "))",
            preferredStyle: .alert
        )
        
        let copyAction = UIAlertAction(title: "Copy Link", style: .default) { _ in
            UIPasteboard.general.string = mockURL
            
            let copiedAlert = UIAlertController(
                title: "Copied! 📋",
                message: "The link has been copied to your clipboard. You can now email it to your vet in Portugal!",
                preferredStyle: .alert
            )
            copiedAlert.addAction(UIAlertAction(title: "Done", style: .default) { _ in
                self.navigationController?.popToRootViewController(animated: true)
            })
            self.present(copiedAlert, animated: true)
        }
        
        let shareAction = UIAlertAction(title: "Share", style: .default) { _ in
            let activityVC = UIActivityViewController(
                activityItems: [mockURL],
                applicationActivities: nil
            )
            self.present(activityVC, animated: true)
        }
        
        successAlert.addAction(copyAction)
        successAlert.addAction(shareAction)
        successAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(successAlert, animated: true)
    }
}