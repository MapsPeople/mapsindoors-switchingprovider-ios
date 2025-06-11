# MapsIndoors Switching Position Provider for iOS

## Overview

This Swift Package is an example of a Position Provider for MapsIndoors that can take a number of other Position Providers and return the "best" result available. "Best" is in this example the position with the lowest accuracy.

## Requirements

* iOS 15.0 or later
* Xcode 16 or later
* MapsIndoors iOS SDK (using either [Mapbox Maps](https://github.com/MapsPeople/mapsindoors-mapbox-ios) or [Google Maps](https://github.com/MapsPeople/mapsindoors-googlemaps-ios)
* A MapsIndoors API key

## Installation

### Using Swift Package Manager in Xcode

1.  In Xcode, open your project.
2.  Go to `File` -> `Add Package Dependencies…`
3.  Enter the repository URL for this package (https://github.com/MapsPeople/mapsindoors-switchingprovider-ios.git)
4.  Follow the prompts to select the package and target for installation.

### Using Swift Package Manager Manifest

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/MapsPeople/mapsindoors-switchingprovider-ios.git", .upToNextMajor(from: "1.0.0")),
]
```

### Fork the repository

If you prefer more control, want to understand how it works, or want to customize the position provider package, you can fork this repository. By forking the repository, you create your own copy of the project, which you can modify to suit your specific requirements while retaining the base functionality.

1.  Fork the repository to your own GitHub account.
2.  Clone the forked repository to your local machine.
3.  Add the forked repository as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/YOUR_USERNAME/mapsindoors-switchingprovider-ios.git", .upToNextMajor(from: "1.0.0")),
]
```

## Usage

The position provider should only be initialized when user positioning is required. It depends on MapsIndoors being initialized.

### 1. Prerequisites

* Obtain the necessary API keys and credentials for MapsIndoors.
    * Get MapsIndoors API key from the MapsIndoors CMS, or contact MapsPeople. 

### 2. Configure Info.plist

Follow the instructions for requesting permissions for each individual Position Provider.

### 3. Import the Module

```swift
// Import the MapsIndoors SDK
import MapsIndoors
// Import the Switching Position Provider for MapsIndoors
import SwitchingPositionProvider
```

### 4. Set up the Switching Position Provider for MapsIndoors

```swift
// Initialize the Switching PositionProvider.
let switchingPositionProvider = SwitchingPositionProvider()

// Add position providers to select "best" result from
let switchingPositionProvider = SwitchingPositionProvider()
let crowdConnectedPositionProvider = CrowdConnectedPositionProvider(appKey: "YOUR_CROWDCONNECTED_APP_KEY", token: "YOUR_CROWDCONNECTED_TOKEN", secret: "YOUR_CROWDCONNECTED_SECRET")
switchingPositionProvider.addPositionProvider(crowdConnectedPositionProvider)

// Use the Switching Position Provider in MapsIndoors.
MPMapsIndoors.shared.positionProvider = switchingPositionProvider
mapControl?.showUserPosition = true
```
