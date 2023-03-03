import XCTest
@testable import MonoMock

final class MonoMockTests: XCTestCase {
    private var mockClass: MockClass!
    
    override func setUp() {
        mockClass = MockClass()
    }
    
    override func tearDown() {
        mockClass = nil
    }
    
    func testStub() throws {
        let expectedValue = 3
        mockClass.mockRepeatValue.stub = { (value: Int) in
            return value + 1
        }
        
        XCTAssertEqual(mockClass.repeatValue(expectedValue), expectedValue + 1)
    }
    
    func testCallCount() throws {
        let expectedValue = 3
        mockClass.mockRepeatValue.stub = { (value: Int) in
            return value + 1
        }
        
        let repeatCount = 10
        for _ in 0..<repeatCount {
            _ = mockClass.repeatValue(expectedValue)
        }
        
        XCTAssertEqual(mockClass.mockRepeatValue.isCalled, true)
        XCTAssertEqual(mockClass.mockRepeatValue.callCount, repeatCount)
    }
}

protocol MockProtocol {
    func repeatValue(_ num: Int) -> Int
}

fileprivate class MockClass: MockProtocol {
    lazy var mockRepeatValue = MockFunction(repeatValue)
    
    func repeatValue(_ num: Int) -> Int {
        mockRepeatValue(num)
    }
}
