// ------------------------------------------------ //

// - MARK: Properties

// ------------------------------------------------ //

// • Stored property •

class Office {
    let numberOfRooms: Int
    var waterCoolerBottles = 2

    init(numberOfRooms: Int) {
        self.numberOfRooms = numberOfRooms
    }
}

// • Lazy stored property •

struct FamilyTree {
    init() {
        print("Looking for all ancestors through the centuries...Creating family tree!")
    }
}

struct Person {
    var name: String
    lazy var familyTree = FamilyTree() // because this may take very long time, and we may not even use it

    init(name: String) {
        self.name = name
    }
}

var person = Person(name: "Ivan")

// • Computed property (with getter & setter) •

struct Point {
    var x = 0.0
    var y = 0.0
}

struct Size {
    var width = 0.0
    var height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

// • Computed property (read-only) •

struct Cube {
    var side = 0.0

    var volume: Double {
        get {
            return side * side * side // it is read-only (only getter), because it doesn't makes sense to mutate it
        }
        // shorthand getter notation
    }
}

let cube = Cube(side: 4.0)
print("the volume of cube is \(cube.volume)")

// • Type property •

enum SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }

    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

class SomeSubclass: SomeClass {
    override class var overrideableComputedTypeProperty: Int {
        return 777
    }
}

print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
print(SomeEnumeration.computedTypeProperty)
print(SomeClass.computedTypeProperty)
print(SomeSubclass.overrideableComputedTypeProperty)

// ------------------------------------------------ //

// - MARK: Property observers

// ------------------------------------------------ //

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 300
// About to set totalSteps to 300
// Added 100 steps
stepCounter.totalSteps = 900
// About to set totalSteps to 900
// Added 600 steps

enum UserStatus {
    case online
    case offline
}

class Chat {
    var user1Status = UserStatus.offline {
        didSet {
            if oldValue == .offline {
                print("User1 went online!")
            } else {
                print("User1 went offline!")
            }
            updateUI()
        }
    }
    var user2Status = UserStatus.offline {
        didSet {
            if oldValue == .offline {
                print("User2 went online!")
            } else {
                print("User2 went offline!")
            }
            updateUI()
        }
    }
    
    private func updateUI() {
        print("reacting to the changes and updating the UI...")
    }
    
}

let chat = Chat()
chat.user1Status = .online
chat.user1Status = .offline

// ------------------------------------------------ //

// - MARK: Property wrappers

// ------------------------------------------------ //

@propertyWrapper
struct PositiveOnly {
    private var internalValue: Int

    var wrappedValue: Int {
        get {
            return internalValue
        }
        set {
            internalValue = max(newValue, 0)
        }
    }
    
    init(wrappedValue: Int) {
        internalValue = max(wrappedValue, 0)
    }
}

struct PositiveOnlyTest {
    @PositiveOnly var positive = 5
    @PositiveOnly var negative = -10
}

var test = PositiveOnlyTest()
test.negative
test.positive


@propertyWrapper
struct LessThan {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get {
            return number
        }
        set {
            number = min(newValue, maximum)
        }
    }

    init() {
        maximum = 12
        number = 0
    }
    
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct NarrowRectangle {
    @LessThan(wrappedValue: 2, maximum: 5) var height: Int
    @LessThan(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// Prints "2 3"

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// Prints "5 4"

// ------------------------------------------------ //

// - MARK: Functions again

// ------------------------------------------------ //

// • Revise functions •


func screamToEveryone(with word: String) -> String {
    "HEY, EVERYONE!!! \(word.uppercased())" // implicit return
}

func addOneAndPrint(number: Int) {
    print(number + 1)
}

func sayHi(to someone: String? = nil) {
    if let someone = someone {
        print("Hi, \(someone)")
    } else {
        print("Hi, everyone!")
    }
}

// • First-class citizens, storing to var •

struct Pet {
    var nickname: String
    var kind: Kind = .home
    
    enum Kind {
        case home
        case wild
    }
}

var pets: [Pet] = []

func addPet(_ pet: Pet) {
    pets.append(pet)
}

var petAdder: (Pet) -> () = addPet // or -> Void

petAdder(Pet(nickname: "Fluffy"))
// both are the same
addPet(Pet(nickname: "Fluffy"))

func getKind(of pet: Pet) -> Pet.Kind {
    pet.kind
}

var kindGetter: (Pet) -> Pet.Kind = getKind

kindGetter(Pet(nickname: "Drago", kind: .wild))
// both are the same
getKind(of: Pet(nickname: "Drago", kind: .wild))

// • First-class citizens, function as paremeter type •

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Prints "Result: 8"

// • First-class citizens, function as return type •

func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = -3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the stepForward() function

print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
