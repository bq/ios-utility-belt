import Foundation

protocol DefinesPrimaryKey: Equatable {
    associatedtype PrimaryKey

    var primaryKey: PrimaryKey { get }
}

func ==<T: DefinesPrimaryKey>(lhs: T, rhs: T) -> Bool where T.PrimaryKey: Equatable {
    return lhs.primaryKey == rhs.primaryKey
}
