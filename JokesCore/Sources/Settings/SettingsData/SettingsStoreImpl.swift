import RxCocoa
import RxSwift
import SettingsDomain
import UIKit

public struct SettingsStoreImpl: SettingsStore {
    
    public var firstNameObservable: Observable<String?> {
        userDefaults.rx
            .observe(String.self, firstNameKey)
            .startWith(userDefaults.value(forKey: firstNameKey) as? String)
    }
    
    public var lastNameObservable: Observable<String?> {
        userDefaults.rx
            .observe(String.self, lastNameKey)
            .startWith(userDefaults.value(forKey: lastNameKey) as? String)
    }
    
    public var isOfflineModeObservable: Observable<Bool> {
        userDefaults.rx
            .observe(Bool.self, offlineModeKey)
            .map { $0 ?? false }
            .startWith(userDefaults.bool(forKey: offlineModeKey))
    }
    
    public var lastName: String? { userDefaults.value(forKey: lastNameKey) as? String }
    public var firstName: String? { userDefaults.value(forKey: firstNameKey) as? String }
    public var isOfflineMode: Bool { userDefaults.bool(forKey: offlineModeKey) }
    
    private var lastNameKey: String { settingsStoreKey + SettingsStoreKeys.lastName.rawValue }
    private var firstNameKey: String { settingsStoreKey + SettingsStoreKeys.firstName.rawValue }
    private var offlineModeKey: String { settingsStoreKey + SettingsStoreKeys.offlineMode.rawValue }
    
    private let userDefaults: UserDefaults
    private let settingsStoreKey: String
    
    public init(userDefaults: UserDefaults, SettingsStoreKey: String? = nil) {
        self.userDefaults = userDefaults
        self.settingsStoreKey = SettingsStoreKey ?? String(describing: Self.self)
    }
    
    public func updateFirstName(_ name: String?) {
        userDefaults.set(name, forKey: firstNameKey)
    }
    
    public func updateLastName(_ name: String?) {
        userDefaults.set(name, forKey: lastNameKey)
    }
    
    public func setOfflineMode(to value: Bool) {
        userDefaults.set(value, forKey: offlineModeKey)
    }
}
