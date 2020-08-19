import RxSwift
import RxCocoa

public extension ObservableType {
    
    func asUnsafeDriver() -> Driver<Element> {
        asDriver { error in
            fatalError("Unexpected error on converting Observable to Driver: " + error.localizedDescription)
        }
    }
}
