import UIKit

class PhotoUploadViewController: UIViewController {
    
    // UI Elements
    private let imageView = UIImageView()
    private let catSelectionButton = UIButton(type: .system)
    private let takePhotoButton = UIButton(type: .system)
    private let choosePhotoButton = UIButton(type: .system)
    private let analyzeButton = UIButton(type: .system)
    private let resultView = UIView()
    private let scoreLabel = UILabel()
    private let analysisLabel = UILabel()
    private let wellnessLabel = UILabel()
    
    // Data
    private var selectedCat: Cat?
    private var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Pay Your Cat Tax"
        
        // Navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        
        // Image view
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = .systemGray5
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.tintColor = .systemGray3
        
        // Cat selection button
        catSelectionButton.setTitle("Select Your Cat", for: .normal)
        catSelectionButton.backgroundColor = .systemOrange
        catSelectionButton.tintColor = .white
        catSelectionButton.layer.cornerRadius = 8
        catSelectionButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        catSelectionButton.addTarget(self, action: #selector(selectCatTapped), for: .touchUpInside)
        
        // Take photo button
        takePhotoButton.setTitle("📷 Take Photo", for: .normal)
        takePhotoButton.backgroundColor = .systemBlue
        takePhotoButton.tintColor = .white
        takePhotoButton.layer.cornerRadius = 8
        takePhotoButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        takePhotoButton.addTarget(self, action: #selector(takePhotoTapped), for: .touchUpInside)
        
        // Choose photo button
        choosePhotoButton.setTitle("🖼️ Choose Photo", for: .normal)
        choosePhotoButton.backgroundColor = .systemGreen
        choosePhotoButton.tintColor = .white
        choosePhotoButton.layer.cornerRadius = 8
        choosePhotoButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        choosePhotoButton.addTarget(self, action: #selector(choosePhotoTapped), for: .touchUpInside)
        
        // Analyze button
        analyzeButton.setTitle("✨ Analyze & Score", for: .normal)
        analyzeButton.backgroundColor = .systemPurple
        analyzeButton.tintColor = .white
        analyzeButton.layer.cornerRadius = 8
        analyzeButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        analyzeButton.addTarget(self, action: #selector(analyzeTapped), for: .touchUpInside)
        analyzeButton.isEnabled = false
        analyzeButton.alpha = 0.5
        
        // Result view
        resultView.backgroundColor = .systemBackground
        resultView.layer.cornerRadius = 16
        resultView.layer.shadowColor = UIColor.black.cgColor
        resultView.layer.shadowOffset = CGSize(width: 0, height: 2)
        resultView.layer.shadowRadius = 8
        resultView.layer.shadowOpacity = 0.1
        resultView.isHidden = true
        
        // Score label
        scoreLabel.font = .systemFont(ofSize: 32, weight: .bold)
        scoreLabel.textColor = .systemOrange
        scoreLabel.textAlignment = .center
        
        // Analysis label
        analysisLabel.font = .systemFont(ofSize: 16)
        analysisLabel.textColor = .label
        analysisLabel.numberOfLines = 0
        analysisLabel.textAlignment = .center
        
        // Wellness label
        wellnessLabel.font = .systemFont(ofSize: 14, weight: .medium)
        wellnessLabel.textColor = .systemGreen
        wellnessLabel.numberOfLines = 0
        wellnessLabel.textAlignment = .center
        
        // Add views
        view.addSubview(imageView)
        view.addSubview(catSelectionButton)
        view.addSubview(takePhotoButton)
        view.addSubview(choosePhotoButton)
        view.addSubview(analyzeButton)
        view.addSubview(resultView)
        resultView.addSubview(scoreLabel)
        resultView.addSubview(analysisLabel)
        resultView.addSubview(wellnessLabel)
        
        // Setup auto layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        catSelectionButton.translatesAutoresizingMaskIntoConstraints = false
        takePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        choosePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        analyzeButton.translatesAutoresizingMaskIntoConstraints = false
        resultView.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        analysisLabel.translatesAutoresizingMaskIntoConstraints = false
        wellnessLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Image view
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Cat selection button
            catSelectionButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            catSelectionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            catSelectionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            catSelectionButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Take photo button
            takePhotoButton.topAnchor.constraint(equalTo: catSelectionButton.bottomAnchor, constant: 16),
            takePhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            takePhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            takePhotoButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Choose photo button
            choosePhotoButton.topAnchor.constraint(equalTo: catSelectionButton.bottomAnchor, constant: 16),
            choosePhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            choosePhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            choosePhotoButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Analyze button
            analyzeButton.topAnchor.constraint(equalTo: takePhotoButton.bottomAnchor, constant: 20),
            analyzeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            analyzeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            analyzeButton.heightAnchor.constraint(equalToConstant: 60),
            
            // Result view
            resultView.topAnchor.constraint(equalTo: analyzeButton.bottomAnchor, constant: 20),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resultView.heightAnchor.constraint(equalToConstant: 200),
            
            // Score label
            scoreLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -20),
            
            // Analysis label
            analysisLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 16),
            analysisLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 20),
            analysisLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -20),
            
            // Wellness label
            wellnessLabel.topAnchor.constraint(equalTo: analysisLabel.bottomAnchor, constant: 12),
            wellnessLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 20),
            wellnessLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -20),
            wellnessLabel.bottomAnchor.constraint(lessThanOrEqualTo: resultView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func selectCatTapped() {
        let actionSheet = UIAlertController(title: "Select Your Cat", message: "Which cat is this photo for?", preferredStyle: .actionSheet)
        
        // Mock cats data
        let mockCats = [
            Cat(name: "Simba", breed: "Maine Coon", age: 3, imageName: "cat1", microchipNumber: "123456789012345"),
            Cat(name: "Luna", breed: "British Shorthair", age: 2, imageName: "cat2", microchipNumber: "123456789012346"),
            Cat(name: "Milo", breed: "Persian", age: 5, imageName: "cat3", microchipNumber: "123456789012347")
        ]
        
        for cat in mockCats {
            actionSheet.addAction(UIAlertAction(title: cat.name, style: .default) { _ in
                self.selectedCat = cat
                self.catSelectionButton.setTitle("Selected: \(cat.name)", for: .normal)
                self.updateAnalyzeButtonState()
            })
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = actionSheet.popoverPresentationController {
            popover.sourceView = catSelectionButton
            popover.sourceRect = catSelectionButton.bounds
        }
        
        present(actionSheet, animated: true)
    }
    
    @objc private func takePhotoTapped() {
        // Simulate taking a photo
        let mockImage = createMockCatImage()
        selectedImage = mockImage
        imageView.image = mockImage
        updateAnalyzeButtonState()
    }
    
    @objc private func choosePhotoTapped() {
        // Simulate choosing a photo
        let mockImage = createMockCatImage()
        selectedImage = mockImage
        imageView.image = mockImage
        updateAnalyzeButtonState()
    }
    
    @objc private func analyzeTapped() {
        guard let cat = selectedCat, selectedImage != nil else { return }
        
        // Simulate AI analysis with loading
        analyzeButton.setTitle("🤖 Analyzing...", for: .normal)
        analyzeButton.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showAnalysisResults(for: cat)
        }
    }
    
    private func updateAnalyzeButtonState() {
        let canAnalyze = selectedCat != nil && selectedImage != nil
        analyzeButton.isEnabled = canAnalyze
        analyzeButton.alpha = canAnalyze ? 1.0 : 0.5
    }
    
    private func createMockCatImage() -> UIImage {
        // Create a simple colored square as a mock image
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.systemOrange.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    private func showAnalysisResults(for cat: Cat) {
        // Generate mock results
        let scores = [8.5, 9.2, 9.8, 8.9, 9.5, 7.8, 9.1]
        let randomScore = scores.randomElement() ?? 9.0
        
        let analyses = [
            "Perfection! 10/10 for paw tuck. 9/10 for loaf form.",
            "Excellent hunting pose! Love those alert ears.",
            "Perfect sunbathing technique. Master of relaxation.",
            "Those eyes! Absolutely mesmerizing. Pure cuteness.",
            "Classic cat behavior. The judgment in those eyes is strong!"
        ]
        
        let wellness = [
            "AI sees a shiny coat! ✨",
            "Active and playful - great signs! 🎯",
            "Getting that vitamin D! ☀️",
            "Healthy posture and alertness! 💪",
            "Those whiskers look magnificent! 😸"
        ]
        
        // Reset analyze button
        analyzeButton.setTitle("✨ Analyze & Score", for: .normal)
        analyzeButton.isEnabled = true
        
        // Show results
        scoreLabel.text = String(format: "%.1f/10", randomScore)
        analysisLabel.text = "AI Analysis: \"\(analyses.randomElement() ?? "")\""
        wellnessLabel.text = "Wellness Check: \(wellness.randomElement() ?? "")"
        
        resultView.isHidden = false
        
        // Animate result view
        resultView.alpha = 0
        resultView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: [], animations: {
            self.resultView.alpha = 1
            self.resultView.transform = .identity
        }, completion: { _ in
            self.showPostAnalysisOptions(score: randomScore, cat: cat)
        })
    }
    
    private func showPostAnalysisOptions(score: Double, cat: Cat) {
        let alert = UIAlertController(
            title: "Cat Tax Paid! 🎉",
            message: "\(cat.name) scored \(String(format: "%.1f", score))/10! What would you like to do next?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "📤 Share to Social Media", style: .default) { _ in
            self.showShareOptions()
        })
        
        alert.addAction(UIAlertAction(title: "📝 Add to Feed", style: .default) { _ in
            self.showFeedAddedAlert()
        })
        
        alert.addAction(UIAlertAction(title: "✅ Done", style: .default) { _ in
            self.dismiss(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    private func showShareOptions() {
        let alert = UIAlertController(
            title: "Share Options",
            message: "In a full implementation, this would open the native share sheet to post to Instagram, Facebook, Twitter, etc.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Got it!", style: .default))
        present(alert, animated: true)
    }
    
    private func showFeedAddedAlert() {
        let alert = UIAlertController(
            title: "Added to Feed! 📱",
            message: "Your Cat Tax payment has been added to the Home Feed for everyone to see!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Awesome!", style: .default) { _ in
            self.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
}