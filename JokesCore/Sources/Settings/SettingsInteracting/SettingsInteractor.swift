import RxSwift
import SettingsDomain

public final class SettingsInteractor {
    
    public let state: Observable<SettingsState>
    
    private let partial = PublishSubject<PartialStateChange>()
    private let store: SettingsStore
    private let disposeBag = DisposeBag()
    
    public init(store: SettingsStore) {
        self.store = store
        
        let initial = SettingsState(
            lastName: store.lastName,
            firstName: store.firstName,
            isOfflineMode: store.isOfflineMode
        )
        
        state = partial.scan(initial, accumulator: SettingsState.reduce)
            .startWith(initial)
            .share(replay: 1, scope: .forever)
        
        bind()
    }
    
    private func bind() {
        store.lastNameObservable
            .map(PartialStateChange.lastNameDidChange)
            .subscribe(onNext: partial.onNext)
            .disposed(by: disposeBag)
        
        store.firstNameObservable
            .map(PartialStateChange.firstNameDidChange)
            .subscribe(onNext: partial.onNext)
            .disposed(by: disposeBag)
        
        store.isOfflineModeObservable
            .map(PartialStateChange.offlineModeDidChange)
            .subscribe(onNext: partial.onNext)
            .disposed(by: disposeBag)
    }
}

extension SettingsInteractor: SettingsInteracting {
    
    public func updateFirstName(to name: String?) {
        let value = name.map { $0.isEmpty ? nil : $0 }
        store.updateFirstName(value ?? nil)
    }
    
    public func updateLastName(to name: String?) {
        let value = name.map { $0.isEmpty ? nil : $0 }
        store.updateLastName(value ?? nil)
    }
    
    public func setOfflineMode(to value: Bool) {
        store.setOfflineMode(to: value)
    }
}
