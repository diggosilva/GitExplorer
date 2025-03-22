//
//  GitExplorerTests.swift
//  GitExplorerTests
//
//  Created by Diggo Silva on 22/03/25.
//

import XCTest
@testable import GitExplorer

class MockSearch: ServiceProtocol {
    var isSuccess: Bool = true
    
    func getUser(with username: String, completion: @escaping (Result<User, DSError>) -> Void) {
        if isSuccess {
            completion(.success(User(login: username, avatarUrl: "", url: "", htmlURL: "", publicRepos: 4, publicGists: 3, followers: 2, following: 1, createdAt: Date())))
        } else {
            completion(.failure(.invalidUsername))
        }
    }
    
    func getRepos(with username: String, completion: @escaping (Result<[Repo], DSError>) -> Void) {}
}

final class GitExplorerTests: XCTestCase {
    
    //MARK: TESTS SUCCESS
    func testWhenUserIsSuccess() {
        let mockService = MockSearch()
        let sut = SearchViewModel(service: mockService)
        
        sut.searchText = "Diggo"
        sut.fetchUser(username: "Diggo")
        
        XCTAssertEqual(sut.user?.login, "Diggo")
        XCTAssertEqual(sut.user?.avatarUrl, "")
        XCTAssertEqual(sut.user?.publicRepos, 4)
        XCTAssertEqual(sut.user?.publicGists, 3)
        XCTAssertEqual(sut.user?.followers, 2)
        XCTAssertEqual(sut.user?.following, 1)
        
        XCTAssertEqual(sut.state.value, .founded)
    }
    
    func testWhenUserIsSuccessFail() {
        let mockService = MockSearch()
        mockService.isSuccess = false
        
        let sut = SearchViewModel(service: mockService)
        
        sut.searchText = "Diggo"
        sut.fetchUser(username: "Diggo")
                
        XCTAssertNil(sut.user, "Usuário inválido!")
        
        XCTAssertEqual(sut.state.value, .notFound)
    }
    
    func testWhenSearchTextIsEmpty() {
        let mockService = MockSearch()
        let sut = SearchViewModel(service: mockService)
        
        sut.searchText = ""
        
        sut.searchUser(completion: { result in
            switch result {
            case .success(_):
                XCTFail("Esperava-se uma falha, mas obteve Sucesso")
            case .failure(let error):
                XCTAssertEqual(error, .invalidSearchEmpty)
            }
        })
        XCTAssertEqual(sut.state.value, .notFound)
    }
    
    func testWhenSearchTextHasWhiteSpaces() {
        let mockService = MockSearch()
        let sut = SearchViewModel(service: mockService)
        
        sut.searchText = " "
        
        sut.searchUser { result in
            switch result {
            case .success(_):
                XCTFail("Esperava-se uma falha, mas obteve Sucesso")
            case .failure(let error):
                XCTAssertEqual(error, .invalidSearchWhiteSpace)
            }
        }
        XCTAssertEqual(sut.state.value, .notFound)
    }
    
    func testWhenSearchTextIsSuccess() {
        let mockService = MockSearch()
        let sut = SearchViewModel(service: mockService)
        
        sut.searchText = "Diggo"
        
        sut.searchUser { result in
            switch result {
            case .success(let username):
                XCTAssertEqual(username, "Usuário encontrado!")
            case .failure: break
            }
        }
        XCTAssertEqual(sut.state.value, .founded)
    }
    
    
    //MARK: TESTS FAILURE
    func testWhenSearchTextIsEmptyIsFailure() {
        let mockService = MockSearch()
        mockService.isSuccess = false
        
        let sut = SearchViewModel(service: mockService)
        
        sut.searchText = ""
        
        sut.searchUser { result in
            switch result {
            case .success(_):
                XCTFail("Esperava-se uma falha, mas obteve Sucesso")
            case .failure(let error):
                XCTAssertEqual(error, .invalidSearchEmpty)
            }
        }
        XCTAssertEqual(sut.state.value, .notFound)
    }
    
    func testWhenSearchTextHasWhiteSpacesIsFailure() {
        let mockService = MockSearch()
        mockService.isSuccess = false
        
        let sut = SearchViewModel(service: mockService)
        
        sut.searchText = " "
        
        sut.searchUser { result in
            switch result {
            case .success(_):
                XCTFail("Esperava-se uma falha, mas obteve Sucesso")
            case .failure(let error):
                XCTAssertEqual(error, .invalidSearchWhiteSpace)
            }
        }
        XCTAssertEqual(sut.state.value, .notFound)
    }
}
