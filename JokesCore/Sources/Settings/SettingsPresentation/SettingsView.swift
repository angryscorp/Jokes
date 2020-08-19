import Common
import RxCocoa
import RxSwift
import UIKit

public final class SettingsView: UIView {
    
    var offlineModeDidChange: ControlProperty<Bool> { offlineModeSwitch.rx.isOn }
    
    var firstNameDidChange: Observable<String?> {
        firstNameTextField.rx.controlEvent(.allEvents)
            .map { [firstNameTextField] in firstNameTextField.text }
    }
    
    var lastNameDidChange: Observable<String?> {
        lastNameTextField.rx.controlEvent(.allEvents)
            .map { [lastNameTextField] in lastNameTextField.text }
    }
    
    var firstName: Binder<String?> {
        Binder<String?>(self) { view, value in
            view.firstNameTextField.text = value
        }
    }
    
    var lastName: Binder<String?> {
        Binder<String?>(self) { view, value in
            view.lastNameTextField.text = value
        }
    }
    
    var offlineMode: Binder<Bool> {
        Binder<Bool>(self) { view, value in
            view.offlineModeSwitch.isOn = value
        }
    }
    
    private let offlineModeSwitch = UISwitch()
    private let offlineModeTitle = UILabel()
    private let lastNameTitle = UILabel()
    private let lastNameTextField = UITextField()
    private let firstNameTitle = UILabel()
    private let firstNameTextField = UITextField()
    private let properties: SettingsProperties
    
    public init(properties: SettingsProperties) {
        self.properties = properties
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        firstNameTextField.endEditing(true)
        lastNameTextField.endEditing(true)
    }
    
    private func setup() {
        backgroundColor = .defaultBackground
        
        offlineModeTitle.text = properties.offlineModeTitle
        offlineModeSwitch.onTintColor = tintColor
        
        lastNameTitle.text = properties.lastNameTitle
        firstNameTitle.text = properties.firstNameTitle
        lastNameTextField.placeholder = properties.lastNamePlaceholder
        firstNameTextField.placeholder = properties.firstNamePlaceholder
        [firstNameTextField, lastNameTextField].forEach {
            $0.borderStyle = .roundedRect
            $0.clearButtonMode = .always
        }
    }
    
    private func layout() {
        let firstNameStack = UIStackView(arrangedSubviews: [firstNameTitle, firstNameTextField])
        let lastNameStack = UIStackView(arrangedSubviews: [lastNameTitle, lastNameTextField])
        let switchModeStack = UIStackView(arrangedSubviews: [offlineModeTitle, offlineModeSwitch])
        
        let mainStack = UIStackView(arrangedSubviews: [firstNameStack, lastNameStack, switchModeStack])
        mainStack.axis = .vertical
        
        [firstNameStack, lastNameStack, switchModeStack, mainStack].forEach { $0.spacing = 16 }
        [firstNameTitle, lastNameTitle].forEach { $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)}
        
        addSubview(mainStack)
        mainStack.constraint(.all(except: .bottom), to: safeAreaLayoutGuide, constant: 16)
        mainStack.constraint(.bottom, to: safeAreaLayoutGuide, constant: 16).priority = .defaultLow
    }
}
