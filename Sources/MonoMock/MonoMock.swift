import Foundation

public struct MockFunction<Argument, Result> {
    public typealias Impl = (Argument) -> Result
    
    public var stub: Impl?
    private var _callCount: Int = 0
    
    public init(_ original: Impl, stubClosuer: Impl? = nil) {
        self.stub = stubClosuer
    }
    
    public mutating func callAsFunction(_ argument: Argument) -> Result {
        guard let stub else {
            fatalError("Implementation has not been given")
        }
        
        let result = stub(argument)
        _callCount += 1
        
        return result
    }
}

public extension MockFunction {
    var isCalled: Bool {
        callCount >= 1
    }
    
    var callCount: Int {
        self._callCount
    }
}
