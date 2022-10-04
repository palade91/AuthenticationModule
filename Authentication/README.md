# Authentication

A description of this package.

Firebase - add GoogleService-Info to main app

@main
struct MainApp: App {
    
    init() {
        FirebaseApp.configure()
        
        // Authentication config
        Authentication.inject(
            brandTitle: "Authentication Sample App",
            brandColor: UIColor.red
        )
    }
}
