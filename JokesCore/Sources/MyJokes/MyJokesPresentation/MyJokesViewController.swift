import RxCocoa
import RxSwift
import MyJokesDomain
import MyJokesInteracting
import UIKit

public final class MyJokesViewController: UIViewController {
    
    private let properties: MyJokesProperties
    private let interactor: MyJokesInteracting
    private let state: Driver<MyJokesState>
    private let router: MyJokesRouting
    private let disposeBag = DisposeBag()
    
    private lazy var _view = MyJokesView(properties: properties)
    
    public init(
        properties: MyJokesProperties,
        interactor: MyJokesInteracting,
        state: Driver<MyJokesState>,
        router: MyJokesRouting
    ) {
        self.properties = properties
        self.interactor = interactor
        self.state = state
        self.router = router
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
        _view.addButtonTap
            .bind { [weak self] in self?.routeToNewJoke() }
            .disposed(by: disposeBag)
        
        state
            .map(\.jokes)
            .drive(_view.tableView.rx.items(
                cellIdentifier: MyJokesTableViewCell.cellIdentifier,
                cellType: MyJokesTableViewCell.self
            )) { [interactor, properties] (_, joke, cell) in
                cell.update(jokeText: joke.text, deleteButtonTitle: properties.deleteButtonTitle)
                cell.delete.bind(onNext: { interactor.deleteJoke(by: joke.id) }).disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
    }
    
    private func routeToNewJoke() {
        router.attachNewJoke { [weak self] viewController in
            self?.present(viewController, animated: true)
        }
    }
}
