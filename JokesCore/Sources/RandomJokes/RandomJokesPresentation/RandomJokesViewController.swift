import RandomJokesDomain
import RandomJokesInteracting
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

public final class RandomJokesViewController: UIViewController {
    
    typealias Group = SectionModel<String?, Joke>
    typealias DataSource = RxTableViewSectionedReloadDataSource<Group>
    
    private let properties: RandomJokesProperties
    private let interactor: RandomJokesInteracting
    private let state: Driver<RandomJokesState>
    private let disposeBag = DisposeBag()
    
    private lazy var _view = RandomJokesView(properties: properties)
    private lazy var dataSource = DataSource(configureCell: { [_view, properties] dataSource, tableView, indexPath, item in
        let isLast = dataSource.sectionModels[indexPath.section].items.count - 1 == indexPath.row
        return _view.makeCell(isLast: isLast, tableView: tableView, at: indexPath, using: item, with: properties)
    })
    
    public init(
        properties: RandomJokesProperties,
        interactor: RandomJokesInteracting,
        state: Driver<RandomJokesState>
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
        interactor.reloadFeed()
    }
    
    public override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            interactor.reloadFeed()
        }
    }
    
    private func setup() {
        title = properties.title
    }
    
    private func bind() {
        _view.like
            .subscribe(onNext: { [interactor] in interactor.likeJoke(with: $0) })
            .disposed(by: disposeBag)
        
        _view.share
            .withLatestFrom(state) { ($1.jokes, $0) }
            .compactMap { jokes, id in jokes.first(where: { $0.id == id }) }
            .subscribe(onNext: { [weak self] in self?.shareJoke($0) })
            .disposed(by: disposeBag)
        
        _view.loadingRequested
            .withLatestFrom(state)
            .filter { $0.status != .loading}
            .emit(onNext: { [interactor] _ in interactor.loadNextJokes() })
            .disposed(by: disposeBag)
        
        state.map(\.jokes)
            .distinctUntilChanged()
            .map { [Group(model: nil, items: $0)]}
            .drive(_view.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        state.map { $0.status == .loading }
            .distinctUntilChanged()
            .withLatestFrom(state) { ($0, $1.jokes.isEmpty) }
            .drive(_view.loadingStatus)
            .disposed(by: disposeBag)
        
        state
            .compactMap { [properties] in $0.asErrorMessage(properties: properties) }
            .drive(onNext: { [weak self] in self?.showErrorMessage($0) })
            .disposed(by: disposeBag)
    }
    
    private func shareJoke(_ joke: Joke) {
        let items = [joke.text]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = _view.tableView
        activityViewController.popoverPresentationController?.sourceRect = CGRect(
            origin: CGPoint(x: _view.tableView.frame.midX, y: 0),
            size: .zero
        )
        present(activityViewController, animated: true)
    }
    
    private func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: properties.errorAlertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: properties.alertButtonTitle, style: .default))
        present(alert, animated: true)
    }
}

private extension RandomJokesState {
    
    func asErrorMessage(properties: RandomJokesProperties) -> String? {
        guard case .error(let error) = status else {
            return nil
        }
        switch error {
        case RandomJokesError.emptyCache:
            return properties.emptyCacheError
        case RandomJokesError.commonError:
            return properties.commonError
        default:
            return error.localizedDescription
        }
    }
}
