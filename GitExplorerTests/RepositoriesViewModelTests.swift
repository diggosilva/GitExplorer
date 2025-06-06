//
//  RepositoriesViewModelTests.swift
//  GitExplorerTests
//
//  Created by Diggo Silva on 22/03/25.
//

import XCTest
@testable import GitExplorer

//class MockRepositories: ServiceProtocol {
//    var isSuccess: Bool = true
//    
//    func getUser(with username: String, completion: @escaping (Result<User, DSError>) -> Void) {}
//    
//    func getRepos(with username: String, completion: @escaping (Result<[Repo],DSError>) -> Void) {
//        if isSuccess {
//            completion(.success([
//                Repo(name: "FirstRepo", repoDescription: nil, createdAt: Date(), updatedAt: Date(), stargazersCount: 4, forksCount: 3),
//                Repo(name: "SecondRepo", repoDescription: nil, createdAt: Date(), updatedAt: Date(), stargazersCount: 2, forksCount: 1)
//            ]))
//        } else {
//            completion(.failure(.reposFailed))
//        }
//    }
//}
//
//final class RepositoriesViewModelTests: XCTestCase {
//
//    //MARK: TESTS SUCCESS
//    func testWhenGetReposIsCalledWithSuccessShouldReturnRepos() {
//        let mockService = MockRepositories()
//        
//        let user = User(login: "Diggo", avatarUrl: "", url: "", htmlURL: "", publicRepos: 4, publicGists: 3, followers: 2, following: 1, createdAt: Date())
//        
//        let sut = RepositoriesViewModel(user: user, service: mockService)
//        
//        sut.fetchRepos()
//        
//        XCTAssertEqual(sut.numberOrRowInSection(), 2)
//        XCTAssertEqual(sut.cellForRow(at: IndexPath(row: 0, section: 0)).name, "FirstRepo")
//        XCTAssertEqual(sut.cellForRow(at: IndexPath(row: 1, section: 0)).name, "SecondRepo")
//        XCTAssertEqual(sut.repos.count, 2)
//        
//        XCTAssertEqual(sut.state.value, .founded)
//    }
//    
//    func testWhenGetReposIsCalledWithFailureDueToEmptyLoginShouldReturnEmptyArray() {
//        let mockService = MockRepositories()
//        
//        let user = User(login: "", avatarUrl: "", url: "", htmlURL: "", publicRepos: 0, publicGists: 0, followers: 0, following: 0, createdAt: Date())
//        
//        let sut = RepositoriesViewModel(user: user, service: mockService)
//        
//        sut.fetchRepos()
//        
//        XCTAssertEqual(sut.numberOrRowInSection(), 0)
//        XCTAssertEqual(sut.repos.count, 0)
//        
//        XCTAssertEqual(sut.state.value, .notFound)
//    }
//    
//    //MARK: TESTS FAILURE
//    func testWhenGetReposIsCalledWithSuccessAndThenFailShouldReturnEmptyArray() {
//        let mockService = MockRepositories()
//        mockService.isSuccess = false
//        
//        let user = User(login: "Diggo", avatarUrl: "", url: "", htmlURL: "", publicRepos: 0, publicGists: 0, followers: 0, following: 0, createdAt: Date())
//        
//        let sut = RepositoriesViewModel(user: user, service: mockService)
//        
//        sut.fetchRepos()
//        
//        XCTAssertEqual(sut.numberOrRowInSection(), 0)
//        XCTAssertEqual(sut.repos.count, 0)
//        
//        XCTAssertEqual(sut.state.value, .notFound)
//    }
//}
