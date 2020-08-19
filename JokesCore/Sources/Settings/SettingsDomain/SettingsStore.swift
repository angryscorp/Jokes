import RxSwift

public protocol SettingsStore {
    
    var lastName: String? { get }
    var firstName: String? { get }
    var isOfflineMode: Bool { get }
    
    var lastNameObservable: Observable<String?> { get }
    var firstNameObservable: Observable<String?> { get }
    var isOfflineModeObservable: Observable<Bool> { get }
    
    func updateLastName(_ name: String?)
    func updateFirstName(_ name: String?)
    func setOfflineMode(to value: Bool)
}
