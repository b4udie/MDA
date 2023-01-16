//
//  ImageHelperTests.swift
//  MovieDatabaseApiUnitTests
//
//  Created by Val Bratkevich on 31.03.2022.
//

import XCTest
@testable import MovieDatabaseApi

class ImageHelperTests: XCTestCase {

    func testImageHelperURL() throws {
        // Arrange
        let imageHelper = ImageHelper(networkEnvironment: NetworkEnvironemt())
        
        // Act
        let url = imageHelper.createImageURL(with: "testPath", quality: .poster(.w185))
        
        // Assert
        XCTAssertEqual(url, URL(string: "https://image.tmdb.org/t/p/w185/testPath"))
    }
}
