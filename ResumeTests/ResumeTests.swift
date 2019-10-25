//
//  ResumeTests.swift
//  ResumeTests
//
//  Created by Victor Hugo Carvalho Barros on 2019-10-24.
//  Copyright © 2019 HZ Apps. All rights reserved.
//

import XCTest
@testable import Resume

class ResumeTests: XCTestCase {

    func testLoadResume() {
        let expectationLoadResume  = expectation(description: "Load Resume")
        
        var resume: Resume? = nil
        
        _ = APIClient.sharedClient.loadResume()
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                expectationLoadResume.fulfill()
            }) {
                resume = $0
            }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertNotNil(resume)
        XCTAssertEqual(resume?.name, "Victor Barros")
    }

}
