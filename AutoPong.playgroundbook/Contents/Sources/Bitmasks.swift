import SpriteKit

enum CategoryBitmasks: UInt32 {
    case paddle   = 0b00000000
    case ball     = 0b00000001
    case corner   = 0b00000010
    case goal     = 0b00000100
    case kick     = 0b00010000
    case item     = 0b00100000
}

enum CollisionBitmasks: UInt32 {
    case none     = 0b00000000
}

enum ContactTestBitmasks: UInt32 {
    case ball     = 0b00000001
}

