import Darwin
// ------------------------------------------------ //
//
//
// - MARK: Values
//
//
// ------------------------------------------------ //

// • Variables and constants •

var someNumber: Int = 77
someNumber = 55
let name: String = "Dalida"
//name = "Arman" // can't do this

// • String interpolation •


let greeting: String = "Salem, \(name)!"

// • String concatenation •

let typicalMessage: String = greeting + " How are you?"

// • Multiline strings •

let longMessage: String =  """
This is nFactorial iOS Course, Lecture 01.
The very first day when we try our hands on Swift.
It seems to handle long strings quite well.
"""

// • Arrays •

let cities: [String] = ["Almaty", "Karagandy", "Pavlodar", "Taraz"]

// • Dictionaries, Hash Tables •

let isCool: [String: Bool] = [
    "iOS": true,
    "Swift": true,
    "SwiftUI": true,
    "Android": false
]

// • Jargon •

var isHappy: Bool // declaration
isHappy = true // initialization
var orange: String = "Fresh One" // declaration & initialization
orange = "Not so fresh One" // assignment
5 // expression
false // expression
var anotherNumber: Int // statement

// ------------------------------------------------ //


// - MARK: Types


// ------------------------------------------------ //

let compilerKnowsThatItsInteger = 70 // Type inference
let weSayThatItsInteger: Int = 70


let stringyNumber = "123"
let number = Int(stringyNumber) // Type casting
//
// ------------------------------------------------ //


// - MARK: Control Flow


// ------------------------------------------------ //

isHappy = false

if isHappy { // parantheses are omitted
    print("I am happy!")
} else {
    print("I am still happy, it's just an example!")
}

let seasons = ["Summer", "Autumn", "Winter", "Spring"]
for season in seasons {
    print("I love \(season)!")
}

for season in seasons {
    print(isHappy ? "I love \(season) and I am happy!" : "I love \(season) and I am not happy!")
}

for season in seasons {
    print("I love \(season) and I am \(isHappy ? "happy" : "not happy")!")
}

var age = 20
switch age {
case 0:
    print("newborn")
case 1...3:
    print("baby")
case 4...11:
    print("child")
case 12..<20:
    print("teenager")
case 20...100:
    print("adult")
default:
    print("ancient")
}

var i = 0
while(i < 10) {
    print(i)
    i += 1
//    i++ // You can't do this, because it was removed from Swift
}

// • For with ranges •

for j in 1...10 {
    print(j)
}

// • Jumping for •

for q in stride(from: 0, to: 10, by: 2) {
    print(q)
}

for q in stride(from: 0, through: 10, by: 2) {
    print(q)
}

// ------------------------------------------------ //


// - MARK: Functions


// ------------------------------------------------ //

func sayHello(name: String) {
    print("Hello, \(name)!")
}

sayHello(name: "Aldiyar")

// • Argument labels •

func saySalem(to name: String) {
    print("Salem, \(name)!")
}

saySalem(to: "Yerbol") // syntactic sugar

func getHappinessStatus() -> Bool {
    return isHappy
}

func getGreetings(_ person: String) -> String {
    return "Hello, \(person)!"
}

getHappinessStatus()

// ------------------------------------------------ //


// - MARK: Classes and Objects


// ------------------------------------------------ //

class Button {
    let backgroundColor: String
    private var tapCount: Int = 0

    init(backgroundColor: String) {
        self.backgroundColor = backgroundColor // no ambiguity with self -> this
    }

    func tap() {
        increaseTapCount()
        print("hey! someone tapped me \(tapCount) times")
    }

    private func increaseTapCount() {
        tapCount += 1
    }
}

final class LoadingButton: Button {
    var isLoading = false

    override func tap() {
        if isLoading {
            print("you can't tap me – I am loading")
        } else {
            super.tap()
        }
    }

    public func startLoading() {
        isLoading = true
    }

    public func stopLoading() {
        isLoading = false
    }


}

let button = Button(backgroundColor: "red")
let loadingButton = LoadingButton(backgroundColor: "green")

button.tap()
button.tap()
button.tap()

loadingButton.tap()
loadingButton.startLoading()
loadingButton.tap()
loadingButton.stopLoading()
loadingButton.tap()
loadingButton.tap()

// ------------------------------------------------ //


// - MARK: Enums and Structs


// ------------------------------------------------ //

// • Enums •

enum Season {
    case summer
    case autumn
    case winter
    case spring
}

enum Direction {
    case north
    case west
    case south
    case east
}

var direction: Direction = .east
let anotherDirection = Direction.west

// • Switch with enum •

switch direction {
case .west:
    print("I am going to Atyrau!")
case .east:
    print("I am going to Semey!")
case .north:
    print("I am going to Petropavlovsk!")
case .south:
    print("I am going to Shymkent")
// no default needed

}

// • Structs •

struct Point {
    let x: Int
    var y: Int = 0 // alternative declaration notation

}

let point = Point(x: 2, y: 2) // synthesized init
let point2 = Point(x: 2) // synthesized init
point.y
point2.y

//struct ThreeDimensionalPoint: Point { // no inheritance in structs
//    let z: Int
//}

// • Reference type vs value type •

class PersonReferenceType {
    var phoneNumber: String = ""
}

struct PersonValueType {
    var phoneNumber: String = ""
}

// • Reference type •

var rMarat = PersonReferenceType()
var rAidana = PersonReferenceType()

rMarat.phoneNumber = "+77071231212" // Marat writes down phone number
rAidana = rMarat // Marat gives phone number to Aidana, and she doesn't write down phone number for herself, but instead *remembers* that Marat has it

rAidana.phoneNumber = "+77777777777" // Aidana accidentally changes phone number

print(rAidana.phoneNumber) // Both of them
print(rMarat.phoneNumber) // now have the same number

// • Value type •

var vMarat = PersonValueType()
var vAidana = PersonValueType()

vMarat.phoneNumber = "+77071231212" // Marat writes down phone number
vAidana = vMarat // Marat gives phone number to Aidana, and she writes it down and now has her own copy

vAidana.phoneNumber = "+77777777777" // When she accidentally changes it

print(vAidana.phoneNumber) // Only her copy changes
print(vMarat.phoneNumber) // Marat's original phone number remains the same

// ------------------------------------------------ //


// - MARK: Protocols and Extensions


// ------------------------------------------------ //

protocol CanFly {
    func fly()
}

protocol CanRun {
    func run()
}

class Bird: CanFly {
    var wings = 2

    func fly() {
        print("Bird is flying")
    }
}

class Human: CanRun {
    func run() {
        print("Human is running")
    }
}

typealias CanFlyAndCanRun = CanFly & CanRun
typealias AlsoCanFly = CanFly
typealias Aidos = CanFly

class Ironman: CanFlyAndCanRun {
    var hasJetpack = true

    func fly() {
        print("Ironman is flying")
    }

    func run() {
        print("Ironman is running")
    }
}

func giveAcommandToFly(thing: CanFly) {
    thing.fly()
}

giveAcommandToFly(thing: Ironman())
giveAcommandToFly(thing: Bird())

// • Protocol default implementation •

extension CanRun {
    func run() {
        print("I am running")
    }
}

let bird = Bird()
let human = Human()
let ironman = Ironman()

bird.fly()
human.run()
ironman.fly()
ironman.run()

// • Extending not-your types •

extension Int {
    func incrementedByOne() -> Int {
        self + 1
    }
}

let someInt = 1.incrementedByOne()
someInt.incrementedByOne()

// • Use it as any other type •

func showEveryoneWhatYouCan(someone: CanRun) {
    print("Everyone look!")
    someone.run()
}

showEveryoneWhatYouCan(someone: human)

// ------------------------------------------------ //


// - MARK: Optionals


// ------------------------------------------------ //



let stringNumber = "123"
let intNumber = Int(stringNumber)

let nameToAgeDictionary = ["Aldiyar": 18, "Temirlan": 22]
let aldiyarAge = nameToAgeDictionary["Aldiyar"]
let aidanaAge = nameToAgeDictionary["Aidana"]


// • Optional binding •

var quizAnswer: String?
//quizAnswer = "I don't really know, but I think answer is this"
quizAnswer = nil

if quizAnswer != nil {
    // • Force unwrapping •
    print(quizAnswer!)
} else {
    print("it's empty!")
}

if let unwrappedQuizAnswer = quizAnswer {
    print(unwrappedQuizAnswer)
} else {
    print("it's empty!")
}

// • Optional chaining •

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
//let roomCount = john.residence!.numberOfRooms // this one is error

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
