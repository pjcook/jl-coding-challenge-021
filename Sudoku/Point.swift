import Foundation

struct Point {
    let x: Int
    let y: Int
}

extension Point: Hashable, CustomDebugStringConvertible {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    
    static let zero = Point(x: 0, y: 0)
        
    var debugDescription: String {
        return "(\(x):\(y))"
    }
}
