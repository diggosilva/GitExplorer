//
//  RepositoriesViewModelTests.swift
//  GitExplorerTests
//
//  Created by Diggo Silva on 22/03/25.
//

import XCTest
import Combine
@testable import GitExplorer

final class RepositoriesViewModelTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()

    //MARK: TESTS SUCCESS
    func testWhenGetReposIsCalledWithSuccessShouldReturnRepos() async throws {
        let mockService = MockService()
        
        let user = User(login: "Diggo", avatarUrl: "", url: "", htmlURL: "", publicRepos: 4, publicGists: 3, followers: 2, following: 1, createdAt: Date())
        
        let sut = RepositoriesViewModel(user: user, service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .founded")
        
        sut.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                if state == .founded {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchRepos()
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertEqual(sut.numberOrRowInSection(), 2)
        XCTAssertEqual(sut.cellForRow(at: IndexPath(row: 0, section: 0)).name, "FirstRepo")
        XCTAssertEqual(sut.cellForRow(at: IndexPath(row: 1, section: 0)).name, "SecondRepo")
        XCTAssertEqual(sut.repos.count, 2)
    }
    
    func testWhenGetReposIsCalledWithFailureDueToEmptyLoginShouldReturnEmptyArray() async throws {
        let mockService = MockService()
        
        let user = User(login: "", avatarUrl: "", url: "", htmlURL: "", publicRepos: 0, publicGists: 0, followers: 0, following: 0, createdAt: Date())
        
        let sut = RepositoriesViewModel(user: user, service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .notFound")
        
        sut.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                if state == .notFound {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchRepos()
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertEqual(sut.numberOrRowInSection(), 0)
        XCTAssertEqual(sut.repos.count, 0)
    }
    
    //MARK: TESTS FAILURE
    func testWhenGetReposIsCalledWithSuccessAndThenFailShouldReturnEmptyArray() async throws {
        let mockService = MockService()
        mockService.isSuccess = false
        
        let user = User(login: "Diggo", avatarUrl: "", url: "", htmlURL: "", publicRepos: 0, publicGists: 0, followers: 0, following: 0, createdAt: Date())
        
        let sut = RepositoriesViewModel(user: user, service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .notFound")
        
        sut.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                if state == .notFound {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchRepos()
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertEqual(sut.numberOrRowInSection(), 0)
        XCTAssertEqual(sut.repos.count, 0)
    }
}
