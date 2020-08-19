import RxCocoa
import RxSwift
import SettingsInteracting
import UIKit

public final class SettingsViewController: UIViewController {
    
    private let properties: SettingsProperties
    private let interactor: SettingsInteracting
    private let state: Driver<SettingsState>
    private let disposeBag = DisposeBag()
    
    private lazy var _view = SettingsView(properties: properties)
    
    public init(
        properties: SettingsProperties,
        interactor: SettingsInteracting,
        state: Driver<SettingsState>
    ) {
        self.properties = properties
        self.interactor = interactor
        self.state = state
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = _view
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func setup() {
        title = properties.title
    }
    
    private func bind() {
        state.map(\.firstName).drive(_view.firstName).disposed(by: disposeBag)
        state.map(\.lastName).drive(_view.lastName).disposed(by: disposeBag)
        state.map(\.isOfflineMode).drive(_view.offlineMode).disposed(by: disposeBag)
        
        _view.offlineModeDidChange
            .subscribe(onNext: { [interactor] in interactor.setOfflineMode(to: $0) })
            .disposed(by: disposeBag)
        
        _view.firstNameDidChange
            .subscribe(onNext: { [interactor] in interactor.updateFirstName(to: $0) })
            .disposed(by: disposeBag)
        
        _view.lastNameDidChange
            .subscribe(onNext: { [interactor] in interactor.updateLastName(to: $0) })
            .disposed(by: disposeBag)
    }
}
