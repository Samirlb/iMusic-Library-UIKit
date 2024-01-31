import Foundation

class RowDetail {
    var title: RowDetailTitle = .none
    var detail: String = ""
    
    init(title: RowDetailTitle, detail: String) {
        self.title = title
        self.detail = detail
    }
    
    func getTitle() -> String {
        return self.title.rawValue
    }
    
    func getDetail() -> String {
        return self.detail
    }
}
