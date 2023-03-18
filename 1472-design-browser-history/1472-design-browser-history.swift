class BrowserHistory {
    var currentPage : Int
    var pages : [String]
    
    init(_ homepage: String) {
        currentPage = 0
        pages = [homepage]
    }
    
    func visit(_ url: String) {
        if currentPage == pages.count-1 {
            pages.append(url)
        } else {
            pages = Array(pages[0...currentPage])
            pages.append(url)
        }
        
        currentPage = pages.count-1
    }
    
    func back(_ steps: Int) -> String {
        currentPage = max(currentPage-steps, 0)
        return pages[currentPage]
    }
    
    func forward(_ steps: Int) -> String {
        currentPage = min(steps+currentPage, pages.count-1)
        return pages[currentPage]
    }
}

/**
 * Your BrowserHistory object will be instantiated and called as such:
 * let obj = BrowserHistory(homepage)
 * obj.visit(url)
 * let ret_2: String = obj.back(steps)
 * let ret_3: String = obj.forward(steps)
 */