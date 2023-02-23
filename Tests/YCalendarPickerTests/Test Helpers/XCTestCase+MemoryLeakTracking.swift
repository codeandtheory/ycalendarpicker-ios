//
//  XCTestCase+MemoryLeakTracking.swift
//  YCarousel
//
//  Created by Karthik K Manoj on 07/20/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeak(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been deallocated. Potential memory leak.",
                file: file,
                line: line
            )
        }
    }
}
