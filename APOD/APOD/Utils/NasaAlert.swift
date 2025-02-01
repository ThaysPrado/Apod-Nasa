//
//  NasaAlert.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

struct NasaAlert {
    enum Action {
        case ok(handler: (() -> Void)?)
        case retry(handler: (() -> Void)?)
        case close

        var buttonTitle: String {
            switch self {
            case .ok:
                return "OK"
            case .retry:
                return "TENTAR NOVAMENTE"
            case .close:
                return "FECHAR"
            }
        }

        var handler: (() -> Void)? {
            switch self {
            case .ok(let handler):
                return handler
            case .retry(let handler):
                return handler
            case .close:
                return nil
            }
        }
    }
}
