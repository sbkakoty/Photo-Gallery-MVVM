//
//  AlbumPhotoViewModelTest.swift
//  PhotoGalleryCleanTests
//
//  Created by MacBook on 02/08/22.
//

import XCTest
@testable import PhotoGalleryClean

class AlbumPhotoViewModelTest: XCTestCase {

    var viewModelAlbum: AlbumViewModel!
    var viewModelAlbumPhotos: AlbumPhotoViewModel!
    var mockAlbumTitleUseCaseTest: MockAlbumTitleUseCaseTest!
    var mockAlbumPhotoUseCaseTest: MockAlbumPhotoUseCaseTest!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mockAlbumTitleUseCaseTest = MockAlbumTitleUseCaseTest()
        mockAlbumPhotoUseCaseTest = MockAlbumPhotoUseCaseTest()
        viewModelAlbum = AlbumViewModel(albumTitleUseCase:mockAlbumTitleUseCaseTest)
        viewModelAlbumPhotos = AlbumPhotoViewModel(albumPhotoUseCase: mockAlbumPhotoUseCaseTest)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expected = mockAlbumPhotoUseCaseTest.albumPhotos
        
        viewModelAlbumPhotos.getAlbumPhotos(albums: viewModelAlbum.albums)
        
        XCTAssertEqual(viewModelAlbumPhotos.albumPhotos, expected)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
