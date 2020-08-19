import Common
import RandomJokesDomain
import RxCocoa
import RxSwift
import UIKit

public final class RandomJokesView: UIView {
    
    typealias LoadingStatus = (isLoading: Bool, isDataSourceEmpty: Bool)
    
    var like: Observable<Int> { _like }
    var share: Observable<Int> { _share }
    var loadingRequested: Signal<Void> { _loadingRequested.asSignal() }
    
    var loadingStatus: Binder<LoadingStatus> {
        Binder<LoadingStatus>(self) { view, value in
            view.footerIndicator.stopAnimating()
            view.backgroundIndicator.stopAnimating()
            if value.isLoading {
                let indicator = value.isDataSourceEmpty ? view.backgroundIndicator : view.footerIndicator
                indicator.startAnimating()
            }
        }
    }
    
    let tableView = UITableView()
    
    private let _like = PublishSubject<Int>()
    private let _share = PublishSubject<Int>()
    private let _loadingRequested = PublishRelay<Void>()
    
    private let footerIndicator = UIActivityIndicatorView(style: .gray)
    private let backgroundIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private let properties: RandomJokesProperties
    
    public init(properties: RandomJokesProperties) {
        self.properties = properties
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tableView.backgroundView = backgroundIndicator
        tableView.tableFooterView = footerIndicator
        tableView.allowsSelection = false
        tableView.register(RandomJokesTableViewCell.self, forCellReuseIdentifier: RandomJokesTableViewCell.cellIdentifier)
        [footerIndicator, backgroundIndicator].forEach { $0.color = .gray }
    }
    
    private func layout() {
        addSubview(tableView)
        tableView.constraint(.all, to: self)
    }
}

extension RandomJokesView {
    
    func makeCell(
        isLast: Bool,
        tableView: UITableView,
        at indexPath: IndexPath,
        using item: Joke,
        with properties: RandomJokesProperties
    ) -> UITableViewCell {
        let _cell = tableView.dequeueReusableCell(withIdentifier: RandomJokesTableViewCell.cellIdentifier, for: indexPath)
        guard let cell = _cell as? RandomJokesTableViewCell else {
            fatalError("Unexpected cell type")
        }
        
        cell.update(
            jokeText: item.text,
            likeButtonTitle: properties.likeButtonTitle,
            shareButtonTitle: properties.shareButtonTitle
        )
        
        cell.like.bind(onNext: { [weak self] in self?._like.onNext(item.id) }).disposed(by: cell.disposeBag)
        cell.share.bind(onNext: { [weak self] in self?._share.onNext(item.id) }).disposed(by: cell.disposeBag)
        isLast ? _loadingRequested.accept(()) : ()
        
        return cell
    }
}
