//
//  DSError.swift
//  GitExplorer
//
//  Created by Diggo Silva on 14/03/25.
//

import Foundation

enum DSError: String, Error {
    case invalidUsername = "Este nome de usuário criou uma solicitação inválida. Tente novamente."
    case unableToComplete = "Não foi possível concluir sua solicitação. Verifique sua conexão com a internet."
    case invalidResponse = "Resposta inválida do servidor. Tente novamente."
    case invalidData = "Os dados recebidos do servidor eram inválidos. Tente novamente."
    case invalidSearchEmpty = "Digite um nome de usuário para realizar a busca."
    case invalidSearchWhiteSpace = "O campo de busca não pode conter espaços em branco."
    case searchFailed = "Não foi possível encontrar o usuário."
    case reposFailed = "Não foi possível carregar os repositórios. Tente novamente."
}
