//
//  NasaAssignmentTests.swift
//  NasaAssignmentTests
//
//  Created by Admin on 15/06/21.
//

import XCTest
@testable import NasaAssignment

class NasaAssignmentTests: XCTestCase {

    struct HomeViewModel {
        let lists: [String]

        var hasLists: Bool {
            return !lists.isEmpty
        }
    }
    
    
    /// A test case to validate our logic inside the `HomeViewModel`.
    final class HomeViewModelTests: XCTestCase {

        /// It should correctly reflect whether it has lists.
        func testHasLists() {
            let viewModel = HomeViewModel(lists: ["ED05-0223-22", "cif-22", "HQ-22"])
            XCTAssertTrue(viewModel.hasLists)
        }
    }
}
