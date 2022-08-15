@frozen public enum CardValue {
    ///the epoch milliseconds of when the card was created
    case id(Int)
    /// notes.id
    case nid(Int)
    /// deck id (available in col table)
    case did(Int)
    /// ordinal : identifies which of the card templates or cloze deletions it corresponds to
    /// - for card templates, valid values are from 0 to num templates - 1
    /// - for cloze deletions, valid values are from 0 to max cloze index - 1 (they're 0 indexed despite the first being called `c1`)
    case ord(Int)
    /// modificaton time as epoch seconds
    case mod(Int)
    /// update sequence number : used to figure out diffs when syncing.
    /// - value of -1 indicates changes that need to be pushed to server.
    /// - `usn < server usn` indicates changes that need to be pulled from server.
    case usn(Int)
    /// 0=new, 1=learning, 2=review, 3=relearning
    case type(Int)
    /// - -3=user buried(In scheduler 2),
    /// - -2=sched buried (In scheduler 2),
    /// - -2=buried(In scheduler 1),
    /// - -1=suspended,
    /// - 0=new, 1=learning, 2=review (as for type)
    /// - 3=in learning, next rev in at least a day after the previous review
    /// - 4=preview
    case queue(Int)
    /// Due is used differently for different card types:
    /// - new: note id or random int
    /// - due: integer day, relative to the collection's creation time
    /// - learning: integer timestamp in second
    case due(Int)
    /// interval (used in SRS algorithm). Negative = seconds, positive = days
    case ivl(Int)
    /// The ease factor of the card in permille (parts per thousand). If the ease factor is 2500, the card’s interval will be multiplied by 2.5 the next time you press Good.
    case factor(Int)
    /// number of reviews
    case reps(Int)
    /// the number of times the card went from a "was answered correctly" to "was answered incorrectly" state
    case lapses(Int)
    /// of the form a*1000+b, with:
    /// - a the number of reps left today
    /// - b the number of reps left till graduation
    /// - for example: '2004' means 2 reps left today and 4 reps till graduation
    case left(Int)
    /// original due: In filtered decks, it's the original due date that the card had before moving to filtered.
    /// - If the card lapsed in scheduler1, then it's the value before the lapse. (This is used when switching to scheduler 2. At this time, cards in learning becomes due again, with their previous due date)
    /// - In any other case it's 0.
    case odue(Int)
    /// original did: only used when the card is currently in filtered deck
    case odid(Int)
    /// an integer. This integer mod 8 represents a "flag", which can be see in browser and while reviewing a note. Red 1, Orange 2, Green 3, Blue 4, no flag: 0. This integer divided by 8 represents currently nothing
    case flags(Int)
    /// currently unused
    case data(String)
}

extension CardValue {
    var key: String {
        switch self {
        case .id: return "id"
        case .nid: return "nid"
        case .did: return "did"
        case .ord: return "ord"
        case .mod: return "mod"
        case .usn: return "usn"
        case .type: return "type"
        case .queue: return "queue"
        case .due: return "due"
        case .ivl: return "ivl"
        case .factor: return "factor"
        case .reps: return "reps"
        case .lapses: return "lapses"
        case .left: return "left"
        case .odue: return "odue"
        case .odid: return "odid"
        case .flags: return "flags"
        case .data: return "data"
        }
    }

    var value: String {
        switch self {
        case .id(let int): return "\(int)"
        case .nid(let int): return "\(int)"
        case .did(let int): return "\(int)"
        case .ord(let int): return "\(int)"
        case .mod(let int): return "\(int)"
        case .usn(let int): return "\(int)"
        case .type(let int): return "\(int)"
        case .queue(let int): return "\(int)"
        case .due(let int): return "\(int)"
        case .ivl(let int): return "\(int)"
        case .factor(let int): return "\(int)"
        case .reps(let int): return "\(int)"
        case .lapses(let int): return "\(int)"
        case .left(let int): return "\(int)"
        case .odue(let int): return "\(int)"
        case .odid(let int): return "\(int)"
        case .flags(let int): return "\(int)"
        case .data(let string): return string
        }
    }
}
