import RxCocoa
import RxSwift
import UIKit

public final class NewJokeView: UIView {
    
    var save: Signal<String> { saveButton.rx.tap.asSignal().map { [textView] in textView.text } }
    var cancel: ControlEvent<Void> { cancelButton.rx.tap }
    
    private let properties: NewJokeProperties
    private let textLimit = 120
    private let textView = UITextView()
    private let separator = UIView()
    private let symbolCounter = UILabel()
    private let saveButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    private let disposeBag = DisposeBag()
    
    public init(properties: NewJokeProperties) {
        self.properties = properties
        super.init(frame: .zero)
        setup()
        layout()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .defaultBackground
        
        textView.delegate = self
        textView.font = .systemFont(ofSize: 21)
        textView.becomeFirstResponder()
        
        separator.backgroundColor = tintColor
        
        symbolCounter.textAlignment = .right
        symbolCounter.font = .systemFont(ofSize: 12)
        symbolCounter.textColor = .gray
        symbolCounter.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        saveButton.setTitle(properties.saveButtonTitle.uppercased(), for: .normal)
        cancelButton.setTitle(properties.cancelButtonTitle.uppercased(), for: .normal)
    }
    
    private func layout() {
        let stack = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        stack.spacing = 32
        
        [textView, separator, symbolCounter, stack].forEach(addSubview)
        textView.constraint(.all(except: .bottom), to: safeAreaLayoutGuide, constant: 16)
        textView.constraint(.height, to: safeAreaLayoutGuide, multiplier: 1/5)
        
        separator.constraint(.top, to: textView, edge: .bottom, constant: 16)
        separator.constraint([.left, .right], to: safeAreaLayoutGuide, constant: 16)
        separator.constraint(.height, constant: 1)
        
        symbolCounter.constraint(.top, to: separator, constant: 8)
        symbolCounter.constraint([.left, .right], to: safeAreaLayoutGuide, constant: 16)
        
        stack.constraint(.top, to: symbolCounter, edge: .bottom, constant: 16)
        stack.constraint(.right, to: safeAreaLayoutGuide, constant: -16)
        stack.constraint(.left, to: safeAreaLayoutGuide, constant: 16).priority = .defaultLow
        stack.constraint(.bottom, to: safeAreaLayoutGuide, constant: 16).priority = .defaultLow
    }
    
    private func bind() {
        textView.rx.didChange
            .map { [textView] in textView.text.count }
            .startWith(0)
            .map { [properties, textLimit] in properties.symbolCounterFormatter($0, textLimit) }
            .bind(to: symbolCounter.rx.text)
            .disposed(by: disposeBag)
    }
}


extension NewJokeView: UITextViewDelegate {
    
    public func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        guard let currentText = textView.text, let range = Range(range, in: currentText) else {
            return false
        }
        return currentText.replacingCharacters(in: range, with: text).count <= textLimit
    }
}
