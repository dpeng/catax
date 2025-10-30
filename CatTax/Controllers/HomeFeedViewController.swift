import UIKit

class HomeFeedViewController: UIViewController {
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let challengeBanner = UIView()
    private let challengeLabel = UILabel()
    private let challengeIcon = UILabel()
    private let feedTableView = UITableView()
    
    // Sample data for demo
    private var feedItems: [FeedItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadSampleData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Cat Tax"
        
        // Setup navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        // Setup challenge banner
        challengeBanner.backgroundColor = .systemOrange.withAlphaComponent(0.1)
        challengeBanner.layer.cornerRadius = 12
        challengeBanner.layer.borderWidth = 1
        challengeBanner.layer.borderColor = UIColor.systemOrange.withAlphaComponent(0.3).cgColor
        
        challengeIcon.text = "🍞"
        challengeIcon.font = .systemFont(ofSize: 24)
        
        challengeLabel.text = "Today's Cat Tax Challenge: Sleeping Loaves!"
        challengeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        challengeLabel.textColor = .systemOrange
        challengeLabel.numberOfLines = 0
        
        // Setup feed table view
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(FeedItemCell.self, forCellReuseIdentifier: "FeedItemCell")
        feedTableView.backgroundColor = .clear
        feedTableView.separatorStyle = .none
        feedTableView.showsVerticalScrollIndicator = false
        
        // Add views to hierarchy
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(challengeBanner)
        challengeBanner.addSubview(challengeIcon)
        challengeBanner.addSubview(challengeLabel)
        contentView.addSubview(feedTableView)
        
        // Setup auto layout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        challengeBanner.translatesAutoresizingMaskIntoConstraints = false
        challengeIcon.translatesAutoresizingMaskIntoConstraints = false
        challengeLabel.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
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
            
            // Challenge banner
            challengeBanner.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            challengeBanner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            challengeBanner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            challengeBanner.heightAnchor.constraint(equalToConstant: 60),
            
            // Challenge icon
            challengeIcon.leadingAnchor.constraint(equalTo: challengeBanner.leadingAnchor, constant: 16),
            challengeIcon.centerYAnchor.constraint(equalTo: challengeBanner.centerYAnchor),
            
            // Challenge label
            challengeLabel.leadingAnchor.constraint(equalTo: challengeIcon.trailingAnchor, constant: 12),
            challengeLabel.trailingAnchor.constraint(equalTo: challengeBanner.trailingAnchor, constant: -16),
            challengeLabel.centerYAnchor.constraint(equalTo: challengeBanner.centerYAnchor),
            
            // Feed table view
            feedTableView.topAnchor.constraint(equalTo: challengeBanner.bottomAnchor, constant: 20),
            feedTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            feedTableView.heightAnchor.constraint(equalToConstant: 600) // Fixed height for demo
        ])
    }
    
    private func loadSampleData() {
        feedItems = [
            FeedItem(
                catName: "Simba",
                photoName: "cat_sleeping",
                cuteScore: 9.5,
                aiAnalysis: "Perfection! 10/10 for paw tuck. 9/10 for loaf form.",
                wellnessNote: "AI sees a shiny coat! ✨",
                timestamp: Date().addingTimeInterval(-3600)
            ),
            FeedItem(
                catName: "Luna",
                photoName: "cat_playing",
                cuteScore: 8.8,
                aiAnalysis: "Excellent hunting pose! Love those alert ears.",
                wellnessNote: "Active and playful - great signs! 🎯",
                timestamp: Date().addingTimeInterval(-7200)
            ),
            FeedItem(
                catName: "Milo",
                photoName: "cat_sunbathing",
                cuteScore: 9.2,
                aiAnalysis: "Perfect sunbathing technique. Master of relaxation.",
                wellnessNote: "Getting that vitamin D! ☀️",
                timestamp: Date().addingTimeInterval(-10800)
            )
        ]
        feedTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension HomeFeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedItemCell", for: indexPath) as! FeedItemCell
        cell.configure(with: feedItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
}

// MARK: - Data Models
struct FeedItem {
    let catName: String
    let photoName: String
    let cuteScore: Double
    let aiAnalysis: String
    let wellnessNote: String
    let timestamp: Date
}

// MARK: - FeedItemCell (Temporary inline definition)
class FeedItemCell: UITableViewCell {
    
    // UI Elements
    private let containerView = UIView()
    private let catImageView = UIImageView()
    private let catNameLabel = UILabel()
    private let timestampLabel = UILabel()
    private let scoreContainerView = UIView()
    private let scoreLabel = UILabel()
    private let scoreTitleLabel = UILabel()
    private let aiAnalysisLabel = UILabel()
    private let wellnessLabel = UILabel()
    private let shareButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        // Container view
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.1
        
        // Cat image view
        catImageView.contentMode = .scaleAspectFill
        catImageView.clipsToBounds = true
        catImageView.layer.cornerRadius = 12
        catImageView.backgroundColor = .systemGray5
        
        // Cat name label
        catNameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        catNameLabel.textColor = .label
        
        // Timestamp label
        timestampLabel.font = .systemFont(ofSize: 14)
        timestampLabel.textColor = .secondaryLabel
        
        // Score container
        scoreContainerView.backgroundColor = .systemOrange.withAlphaComponent(0.1)
        scoreContainerView.layer.cornerRadius = 8
        scoreContainerView.layer.borderWidth = 1
        scoreContainerView.layer.borderColor = UIColor.systemOrange.withAlphaComponent(0.3).cgColor
        
        // Score label
        scoreLabel.font = .systemFont(ofSize: 24, weight: .bold)
        scoreLabel.textColor = .systemOrange
        scoreLabel.textAlignment = .center
        
        // Score title label
        scoreTitleLabel.text = "Cute-Tax Score"
        scoreTitleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        scoreTitleLabel.textColor = .systemOrange
        scoreTitleLabel.textAlignment = .center
        
        // AI analysis label
        aiAnalysisLabel.font = .systemFont(ofSize: 14)
        aiAnalysisLabel.textColor = .label
        aiAnalysisLabel.numberOfLines = 0
        
        // Wellness label
        wellnessLabel.font = .systemFont(ofSize: 14, weight: .medium)
        wellnessLabel.textColor = .systemGreen
        wellnessLabel.numberOfLines = 0
        
        // Share button
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .systemBlue
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        // Add subviews
        contentView.addSubview(containerView)
        containerView.addSubview(catImageView)
        containerView.addSubview(catNameLabel)
        containerView.addSubview(timestampLabel)
        containerView.addSubview(scoreContainerView)
        scoreContainerView.addSubview(scoreLabel)
        scoreContainerView.addSubview(scoreTitleLabel)
        containerView.addSubview(aiAnalysisLabel)
        containerView.addSubview(wellnessLabel)
        containerView.addSubview(shareButton)
        
        // Setup auto layout
        containerView.translatesAutoresizingMaskIntoConstraints = false
        catImageView.translatesAutoresizingMaskIntoConstraints = false
        catNameLabel.translatesAutoresizingMaskIntoConstraints = false
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreContainerView.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        aiAnalysisLabel.translatesAutoresizingMaskIntoConstraints = false
        wellnessLabel.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Container view
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Cat image view
            catImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            catImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            catImageView.widthAnchor.constraint(equalToConstant: 160),
            catImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Cat name label
            catNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            catNameLabel.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 16),
            catNameLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -16),
            
            // Timestamp label
            timestampLabel.topAnchor.constraint(equalTo: catNameLabel.bottomAnchor, constant: 4),
            timestampLabel.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 16),
            timestampLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -16),
            
            // Share button
            shareButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            shareButton.widthAnchor.constraint(equalToConstant: 30),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Score container
            scoreContainerView.topAnchor.constraint(equalTo: timestampLabel.bottomAnchor, constant: 12),
            scoreContainerView.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 16),
            scoreContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            scoreContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            // Score label
            scoreLabel.topAnchor.constraint(equalTo: scoreContainerView.topAnchor, constant: 8),
            scoreLabel.leadingAnchor.constraint(equalTo: scoreContainerView.leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: scoreContainerView.trailingAnchor),
            
            // Score title label
            scoreTitleLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            scoreTitleLabel.leadingAnchor.constraint(equalTo: scoreContainerView.leadingAnchor),
            scoreTitleLabel.trailingAnchor.constraint(equalTo: scoreContainerView.trailingAnchor),
            scoreTitleLabel.bottomAnchor.constraint(equalTo: scoreContainerView.bottomAnchor, constant: -4),
            
            // AI analysis label
            aiAnalysisLabel.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 16),
            aiAnalysisLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            aiAnalysisLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            // Wellness label
            wellnessLabel.topAnchor.constraint(equalTo: aiAnalysisLabel.bottomAnchor, constant: 8),
            wellnessLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            wellnessLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            wellnessLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with item: FeedItem) {
        catNameLabel.text = item.catName
        scoreLabel.text = String(format: "%.1f/10", item.cuteScore)
        aiAnalysisLabel.text = "AI Analysis: \"\(item.aiAnalysis)\""
        wellnessLabel.text = "Wellness Check: \(item.wellnessNote)"
        
        // Format timestamp
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        timestampLabel.text = formatter.string(from: item.timestamp)
        
        // Set placeholder image (in a real app, you'd load the actual image)
        catImageView.image = UIImage(systemName: "photo")
        catImageView.tintColor = .systemGray3
    }
    
    @objc private func shareButtonTapped() {
        // Handle share button tap
        print("Share button tapped")
    }
}