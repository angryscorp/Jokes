// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "JokesCore",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "JokesCore",
            targets: [
                "Common",
                "RootPresentation",
                "RandomJokesData",
                "RandomJokesDomain",
                "RandomJokesInteracting",
                "RandomJokesPresentation",
                "MyJokesData",
                "MyJokesDomain",
                "MyJokesInteracting",
                "MyJokesPresentation",
                "SettingsData",
                "SettingsDomain",
                "SettingsInteracting",
                "SettingsPresentation",
                "NewJokeInteracting",
                "NewJokePresentation"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "5.1.1")),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources", .upToNextMajor(from: "4.0.1"))
        
    ],
    targets: [
        .target(name: "Common"),
        .target(
            name: "RootPresentation",
            path: "Sources/Root/RootPresentation/"
        ),
        .target(
            name: "RandomJokesData",
            dependencies: ["RxSwift", "RandomJokesDomain", "SettingsDomain"],
            path: "Sources/RandomJokes/RandomJokesData/"
        ),
        .target(
            name: "RandomJokesDomain",
            dependencies: ["RxSwift"],
            path: "Sources/RandomJokes/RandomJokesDomain/"
        ),
        .target(
            name: "RandomJokesInteracting",
            dependencies: ["RxSwift", "RandomJokesDomain", "MyJokesDomain", "SettingsDomain"],
            path: "Sources/RandomJokes/RandomJokesInteracting/"
        ),
        .target(
            name: "RandomJokesPresentation",
            dependencies: ["RxCocoa", "RxDataSources", "RxSwift", "RandomJokesDomain", "RandomJokesInteracting", "Common"],
            path: "Sources/RandomJokes/RandomJokesPresentation/"
        ),
        .target(
            name: "MyJokesData",
            dependencies: ["RxCocoa", "RxSwift", "MyJokesDomain"],
            path: "Sources/MyJokes/MyJokesData/"
        ),
        .target(
            name: "MyJokesDomain",
            dependencies: ["RxSwift"],
            path: "Sources/MyJokes/MyJokesDomain/"
        ),
        .target(
            name: "MyJokesInteracting",
            dependencies: ["RxSwift", "MyJokesDomain"],
            path: "Sources/MyJokes/MyJokesInteracting/"
        ),
        .target(
            name: "MyJokesPresentation",
            dependencies: ["RxCocoa", "RxSwift", "MyJokesDomain", "MyJokesInteracting", "Common"],
            path: "Sources/MyJokes/MyJokesPresentation/"
        ),
        .target(
            name: "NewJokeInteracting",
            dependencies: ["MyJokesDomain"],
            path: "Sources/NewJoke/NewJokeInteracting/"
        ),
        .target(
            name: "NewJokePresentation",
            dependencies: ["RxCocoa", "RxSwift", "NewJokeInteracting", "Common"],
            path: "Sources/NewJoke/NewJokePresentation/"
        ),
        .target(
            name: "SettingsData",
            dependencies: ["RxSwift", "RxCocoa", "SettingsDomain"],
            path: "Sources/Settings/SettingsData/"
        ),
        .target(
            name: "SettingsDomain",
            dependencies: ["RxSwift"],
            path: "Sources/Settings/SettingsDomain/"
        ),
        .target(
            name: "SettingsInteracting",
            dependencies: ["RxSwift", "SettingsDomain"],
            path: "Sources/Settings/SettingsInteracting/"
        ),
        .target(
            name: "SettingsPresentation",
            dependencies: ["RxCocoa", "RxSwift", "SettingsInteracting", "Common"],
            path: "Sources/Settings/SettingsPresentation/"
        )
    ]
)
