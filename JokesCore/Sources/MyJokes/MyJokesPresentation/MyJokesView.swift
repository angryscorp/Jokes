import Common
import RxCocoa
import UIKit

public final class MyJokesView: UIView {
    
    var addButtonTap: ControlEvent<Void> { addButton.rx.tap }
    
    let tableView = UITableView()
    
    private let addButton = UIButton(type: .system)
    private let properties: MyJokesProperties
    
    public init(properties: MyJokesProperties) {
        self.properties = properties
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        addButton.layer.cornerRadius = addButton.bounds.width / 2
    }
    
    private func setup() {
        tableView.allowsSelection = false
        tableView.register(MyJokesTableViewCell.self, forCellReuseIdentifier: MyJokesTableViewCell.cellIdentifier)
        
        addButton.backgroundColor = tintColor
        addButton.setImage(properties.addButtonImage, for: .normal)
        addButton.contentEdgeInsets = .init(top: 12, left: 12, bottom: 12, right: 12)
        addButton.tintColor = .white
    }
    
    private func layout() {
        addSubview(tableView)
        tableView.constraint(.all, to: self)
        
        addSubview(addButton)
        addButton.constraint([.right, .bottom], to: safeAreaLayoutGuide, constant: 16)
        addButton.constraint(size: .init(width: 56, height: 56))
    }
}

