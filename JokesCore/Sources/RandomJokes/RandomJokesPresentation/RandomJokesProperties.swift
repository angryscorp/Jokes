public struct RandomJokesProperties {
    
    let title: String
    let commonError: String
    let emptyCacheError: String
    let errorAlertTitle: String
    let alertButtonTitle: String
    let likeButtonTitle: String
    let shareButtonTitle: String
    
    public init(
        title: String,
        commonError: String,
        emptyCacheError: String,
        errorAlertTitle: String,
        alertButtonTitle: String,
        likeButtonTitle: String,
        shareButtonTitle: String
    ) {
        self.title = title
        self.commonError = commonError
        self.emptyCacheError = emptyCacheError
        self.errorAlertTitle = errorAlertTitle
        self.alertButtonTitle = alertButtonTitle
        self.likeButtonTitle = likeButtonTitle
        self.shareButtonTitle = shareButtonTitle
    }
    
}
