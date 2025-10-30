# 🐱 Cat Tax - iOS App

**"Your cat's life in your pocket. Pay your 'tax' with fun photos, and manage their health with a shareable, digital file cabinet."**

## Overview

Cat Tax is an iOS application that combines fun social features with practical pet management. Users can upload photos of their cats for AI-powered "cuteness scoring" while maintaining comprehensive health records, documents, and sharing capabilities.

## Key Features

### 🏠 Home Feed (Social & Fun)
- Daily Cat Tax challenges
- AI-powered photo scoring system
- Social feed of cat photos with analysis
- Cute-Tax scoring (out of 10)
- Wellness checks from AI analysis

### 🐾 My Cats (Profile Management)
- Complete cat profiles with photos and details
- Four-tab system per cat:
  - **Overview**: Weight charts, key info, reminders
  - **Health Log**: Daily events (food, medication, vet visits)
  - **Documents**: Digital file cabinet for PDFs, scans, notes
  - **Gallery**: Photo collection from Cat Tax payments

### 📤 Share Profile (Core Feature)
Perfect for new locations (like moving to Portugal) or sharing with vets:

#### Option 1: Invite Co-Owner
- Full access for family members or partners
- Can add logs, upload photos, view everything

#### Option 2: Generate Shareable Link ⭐
- **View-only access** for vets, sitters, friends
- **Customizable content**: Choose what to share
- **Time-limited**: 24 hours, 1 week, or permanent
- **Multi-language**: Auto-translate to Portuguese (perfect for international moves)
- **Secure web link**: e.g., `cattax.app/simba-1a8f9c`

### 📸 Cat Tax Station (Upload Center)
- **Pay Your Cat Tax**: Photo upload with AI scoring
- **Log Events**: Food, medication, vet visits, etc.
- **Add Documents**: Scan or upload files
- **Log Weight**: Quick weight tracking

### 🏥 Care Hub
- Find local veterinarians
- Medication reminders
- Appointment scheduling
- Health articles and tips
- Emergency contacts

### ⚙️ Settings
- Account management
- Notification preferences
- Language settings (English/Portuguese)
- Sharing preferences
- Auto-backup options

## Technical Architecture

### Project Structure
```
CatTax/
├── Controllers/
│   ├── MainTabBarController.swift
│   ├── HomeFeedViewController.swift
│   ├── MyCatsViewController.swift
│   ├── CatProfileViewController.swift
│   ├── ShareProfileViewController.swift
│   ├── ShareableLinkOptionsViewController.swift
│   ├── UploadViewController.swift
│   ├── PhotoUploadViewController.swift
│   ├── CareViewController.swift
│   └── SettingsViewController.swift
├── Views/
│   ├── FeedItemCell.swift
│   └── CatCollectionViewCell.swift
├── Models/
│   └── CatTax.xcdatamodeld (Core Data)
├── Services/
└── Supporting Files/
```

### Key Technologies
- **UIKit** for UI development
- **Core Data** for local data persistence
- **Foundation** for data handling
- **Auto Layout** for responsive design
- **iOS 15.0+** minimum deployment target

### Design Philosophy
1. **Fun Hook**: Social photo sharing with AI scoring keeps users engaged
2. **Practical Utility**: Health records and document management provide real value
3. **Seamless Sharing**: Essential for coordinating care or showing new vets
4. **International-Ready**: Multi-language support for global users

## Target Use Cases

### Primary Scenario: Moving to Portugal
- User relocates and needs to show vaccination records to new Portuguese vet
- Creates shareable link with vaccine documents
- Sets language to Portuguese for auto-translation
- Sends secure link via email - vet can access all necessary information

### Daily Use
- Upload cute cat photos for fun scoring
- Log daily health events and medication
- Track weight and health trends
- Share achievements on social media

### Family Coordination
- Invite family members as co-owners
- Everyone can log events and upload photos
- Shared health history and reminders

## Installation & Setup

1. Open `CatTax.xcodeproj` in Xcode 15.0+
2. Select your development team in project settings
3. Choose target device (iPhone recommended)
4. Build and run (⌘+R)

## App Navigation

**5-Tab Bottom Navigation:**
1. **Home Feed** 🏠 - Social features and daily challenges
2. **My Cats** ❤️ - Cat profiles and management
3. **Upload (+)** ➕ - Central action button (larger, prominent)
4. **Care** 🏥 - Health resources and tools
5. **Settings** ⚙️ - App configuration and account

## Future Enhancements

- Real AI integration for photo analysis
- Actual camera and photo library integration
- Cloud sync across devices
- Veterinarian partnership program
- Advanced health analytics
- Social features expansion
- Apple Watch companion app

## Contributing

This is a prototype/demo application. The sharing system and multilingual features are designed specifically for international pet owners who need to coordinate care across borders.

---

**Built with ❤️ for cat parents everywhere** 🐾
