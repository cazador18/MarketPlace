extension String {
    func removingWhiteSpaces() -> String {
        return self.components(separatedBy: .whitespaces).joined()
    }
}
