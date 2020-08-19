import RandomJokesDomain
import RxCocoa
import RxSwift
import UIKit

public final class RandomJokesTableViewCell: UITableViewCell {
    
    var like: ControlEvent<Void> { likeButton.rx.tap }
    var share: ControlEvent<Void> { shareButton.rx.tap }
    
    var disposeBag = DisposeBag()
    
    private let titleLabel = UILabel()
    private let likeButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    
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
    
    func update(jokeText: String, likeButtonTitle: String, shareButtonTitle: String) {
        titleLabel.text = jokeText
        likeButton.setTitle(likeButtonTitle, for: .normal)
        shareButton.setTitle(shareButtonTitle, for: .normal)
    }
    
    private func setup() {
        titleLabel.numberOfLines = 0
    }
    
    private func layout() {
        let stack = UIStackView(arrangedSubviews: [shareButton, likeButton])
        stack.alignment = .trailing
        stack.spacing = 32
        
        [titleLabel, stack].forEach(contentView.addSubview)
        
        titleLabel.constraint(.all(except: .bottom), to: contentView, constant: 16)
        titleLabel.constraint(.bottom, to: stack, edge: .top, constant: -16)
        
        stack.constraint(.right, to: contentView, constant: -32)
        stack.constraint(.bottom, to: contentView, constant: -16)
        stack.constraint(.left, to: contentView, constant: 16).priority = .defaultLow
    }
}
