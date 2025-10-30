import UIKit

class SettingsViewController: UIViewController {
    
    // UI Elements
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // Settings data
    private var settingsSections: [SettingsSection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSettingsData()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        title = "Settings"
        
        // Setup navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        // Setup table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.register(SwitchSettingsCell.self, forCellReuseIdentifier: "SwitchCell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupSettingsData() {
        settingsSections = [
            SettingsSection(title: "Account", items: [
                SettingsItem(title: "Profile", subtitle: "Manage your account", icon: "person.circle", type: .disclosure),
                SettingsItem(title: "Subscription", subtitle: "Cat Tax Premium", icon: "crown", type: .disclosure),
                SettingsItem(title: "Data & Privacy", subtitle: "Control your data", icon: "hand.raised", type: .disclosure)
            ]),
            
            SettingsSection(title: "Notifications", items: [
                SettingsItem(title: "Push Notifications", subtitle: nil, icon: "bell", type: .toggle(true)),
                SettingsItem(title: "Health Reminders", subtitle: nil, icon: "cross.case", type: .toggle(true)),
                SettingsItem(title: "Daily Cat Tax", subtitle: nil, icon: "camera", type: .toggle(true)),
                SettingsItem(title: "Sharing Updates", subtitle: nil, icon: "square.and.arrow.up", type: .toggle(false))
            ]),
            
            SettingsSection(title: "App Preferences", items: [
                SettingsItem(title: "Language", subtitle: "English", icon: "globe", type: .disclosure),
                SettingsItem(title: "Units", subtitle: "Imperial (lbs, °F)", icon: "ruler", type: .disclosure),
                SettingsItem(title: "Photo Quality", subtitle: "High", icon: "camera.aperture", type: .disclosure),
                SettingsItem(title: "Auto-backup", subtitle: nil, icon: "icloud", type: .toggle(true))
            ]),
            
            SettingsSection(title: "Sharing & Collaboration", items: [
                SettingsItem(title: "Default Share Duration", subtitle: "1 Week", icon: "clock", type: .disclosure),
                SettingsItem(title: "Auto-translate Links", subtitle: nil, icon: "translate", type: .toggle(true)),
                SettingsItem(title: "Co-owner Permissions", subtitle: "Manage access", icon: "person.2", type: .disclosure)
            ]),
            
            SettingsSection(title: "Support", items: [
                SettingsItem(title: "Help Center", subtitle: "FAQs and guides", icon: "questionmark.circle", type: .disclosure),
                SettingsItem(title: "Contact Support", subtitle: "Get help", icon: "envelope", type: .disclosure),
                SettingsItem(title: "Rate App", subtitle: "Leave a review", icon: "star", type: .disclosure),
                SettingsItem(title: "About", subtitle: "Version 1.0", icon: "info.circle", type: .disclosure)
            ])
        ]
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsSections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsSections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = settingsSections[indexPath.section].items[indexPath.row]
        
        switch item.type {
        case .toggle(let isOn):
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchSettingsCell
            cell.configure(with: item, switchValue: isOn)
            cell.switchValueChanged = { [weak self] newValue in
                self?.handleSwitchChange(for: item, newValue: newValue)
            }
            return cell
            
        case .disclosure:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.subtitle
            cell.imageView?.image = UIImage(systemName: item.icon)
            cell.imageView?.tintColor = .systemOrange
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = settingsSections[indexPath.section].items[indexPath.row]
        
        if case .disclosure = item.type {
            showSettingsDetail(for: item)
        }
    }
    
    private func handleSwitchChange(for item: SettingsItem, newValue: Bool) {
        // Handle switch changes
        print("Setting '\(item.title)' changed to: \(newValue)")
        
        // Special handling for certain settings
        if item.title == "Push Notifications" && !newValue {
            let alert = UIAlertController(
                title: "Notifications Disabled",
                message: "You won't receive important health reminders and Cat Tax challenges. You can re-enable this in iOS Settings.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    private func showSettingsDetail(for item: SettingsItem) {
        let alert = UIAlertController(
            title: item.title,
            message: "This would open detailed settings for \(item.title.lowercased()).",
            preferredStyle: .alert
        )
        
        // Special handling for certain settings
        switch item.title {
        case "About":
            alert.message = "Cat Tax v1.0\n\nYour cat's life in your pocket.\n\nDeveloped with ❤️ for cat parents everywhere."
            
        case "Rate App":
            alert.message = "Love Cat Tax? Please rate us on the App Store!"
            alert.addAction(UIAlertAction(title: "Rate Now", style: .default))
            
        case "Contact Support":
            alert.message = "Need help? We're here for you!\n\nEmail: support@cattax.app\nResponse time: Usually within 24 hours"
            
        case "Language":
            alert.message = "Choose your preferred language:\n\n🇺🇸 English\n🇵🇹 Português\n🇪🇸 Español\n🇫🇷 Français"
            
        default:
            break
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Settings Data Models
struct SettingsSection {
    let title: String
    let items: [SettingsItem]
}

struct SettingsItem {
    let title: String
    let subtitle: String?
    let icon: String
    let type: SettingsItemType
}

enum SettingsItemType {
    case disclosure
    case toggle(Bool)
}

// MARK: - Custom Switch Cell
class SwitchSettingsCell: UITableViewCell {
    private let toggleSwitch = UISwitch()
    var switchValueChanged: ((Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        toggleSwitch.onTintColor = .systemOrange
        toggleSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        accessoryView = toggleSwitch
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: SettingsItem, switchValue: Bool) {
        textLabel?.text = item.title
        imageView?.image = UIImage(systemName: item.icon)
        imageView?.tintColor = .systemOrange
        toggleSwitch.isOn = switchValue
    }
    
    @objc private func switchChanged() {
        switchValueChanged?(toggleSwitch.isOn)
    }
}