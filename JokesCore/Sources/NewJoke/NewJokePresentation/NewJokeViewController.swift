import Common
import NewJokeInteracting
import RxSwift
import UIKit

public final class NewJokeViewController: UIViewController {
    
    private let properties: NewJokeProperties
    private let interactor: NewJokeInteracting
    private let disposeBag = DisposeBag()
    
    private lazy var _view = NewJokeView(properties: properties)
    
    public init(
        properties: NewJokeProperties,
        interactor: NewJokeInteracting
    ) {
        self.properties = properties
        self.interactor = interactor
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
        _view.save
            .emit(onNext: { [weak self] text in
                self?.interactor.saveJoke(text)
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        _view.cancel
            .subscribe(onNext: { [weak self] in self?.dismiss(animated: true) })
            .disposed(by: disposeBag)
    }
}
