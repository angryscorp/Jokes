import MyJokesDomain
import RxCocoa
import RxSwift
import UIKit

public final class MyJokesTableViewCell: UITableViewCell {
    
    var delete: ControlEvent<Void> { deleteButton.rx.tap }
    var disposeBag = DisposeBag()
    
    private let titleLabel = UILabel()
    private let deleteButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func update(jokeText: String, deleteButtonTitle: String) {
        titleLabel.text = jokeText
        deleteButton.setTitle(deleteButtonTitle, for: .normal)
    }
    
    private func setup() {
        titleLabel.numberOfLines = 0
    }
    
    private func layout() {
        [titleLabel, deleteButton].forEach(contentView.addSubview)
        titleLabel.constraint(.all(except: .bottom), to: contentView, constant: 16)
        deleteButton.constraint(.top, to: titleLabel, edge: .bottom, constant: 16)
        deleteButton.constraint(.right, to: contentView, constant: -32)
        deleteButton.constraint(.bottom, to: contentView, constant: -16)
        deleteButton.constraint(.left, to: contentView, constant: 16).priority = .defaultLow
    }
}
