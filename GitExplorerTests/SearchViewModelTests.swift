//
//  GitExplorerTests.swift
//  GitExplorerTests
//
//  Created by Diggo Silva on 22/03/25.
//

import XCTest
import Combine
@testable import GitExplorer

final class GitExplorerTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testWhenUserIsSuccess() async throws {
        let mockService = MockService()
        let sut = SearchViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .founded")
        
        sut.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                if state == .founded {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
                  
        sut.searchText = "Diggo"
        sut.fetchUser(username: "Diggo")
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertEqual(sut.user?.login, "Diggo")
        XCTAssertEqual(sut.user?.avatarUrl, "")
        XCTAssertEqual(sut.user?.publicRepos, 4)
        XCTAssertEqual(sut.user?.publicGists, 3)
        XCTAssertEqual(sut.user?.followers, 2)
        XCTAssertEqual(sut.user?.following, 1)
    }
    
    func testWhenUserIsSuccessFail() async throws {
        let mockService = MockService()
        mockService.isSuccess = false
        
        let sut = SearchViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .notFound")
        
        sut.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                if state == .notFound {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.searchText = "Diggo"
        sut.fetchUser(username: "Diggo")
        
        await fulfillment(of: [expectation], timeout: 2.0)
                
        XCTAssertNil(sut.user, "Usuário inválido!")
    }
    
    func testWhenSearchTextIsEmpty() {
        let mockService = MockService()
        let sut = SearchViewModel(service: mockService)
        sut.searchText = ""
        
        let expectation = XCTestExpectation(description: "Esperava falha por texto vazio")

        sut.searchUserPublisher()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, .invalidSearchEmpty)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Não deveria receber sucesso")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenSearchTextHasWhiteSpaces() {
        let mockService = MockService()
        let sut = SearchViewModel(service: mockService)
        sut.searchText = "   "
        
        let expectation = XCTestExpectation(description: "Esperava falha por espaços em branco")

        sut.searchUserPublisher()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, .invalidSearchWhiteSpace)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Não deveria receber sucesso")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenSearchTextIsSuccess() {
        let mockService = MockService()
        let sut = SearchViewModel(service: mockService)
        sut.searchText = "Diggo"
        
        let expectation = XCTestExpectation(description: "Esperava sucesso na busca")

        sut.searchUserPublisher()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Esperava sucesso, mas obteve falha")
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, "Usuário encontrado!")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
