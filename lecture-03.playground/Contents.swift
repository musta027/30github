// ------------------------------------------------ //

// - MARK: Generics

// ------------------------------------------------ //

func printInt(value: Int) {
    print(value)
}

func printString(value: String) {
    print(value)
}

// Above two functions have different signatures, but identical bodies, that's the case for generics:

func printValue<T>(value: T) {
    print(value)
}

printValue(value: 10)
printValue(value: "someString")

// Examples of optional types: arrays, dictionaries, optionals

let someArray: Array<Int> = [1, 2, 3]
let someOtherArray: Array<String> = ["ab", "cd", "ef"]

enum MyOptional<Value> {
    case none
    case some(Value)
}

let optionalString: String? = "asd"
let myOptionalString: MyOptional<String> = .some("asd")

print(type(of: optionalString.self))
print(type(of: myOptionalString.self))

// Let's create our own Generic type

class Queue<Element> {
    private var elements: [Element] = []
    
    func enqueue(newElement: Element) {
      elements.append(newElement)
    }

    func dequeue() -> Element? {
      guard !elements.isEmpty else { return nil }
      return elements.remove(at: 0)
    }
    
    func display() {
        print(elements)
    }
}

let queue = Queue<Int>()
queue.enqueue(newElement: 1)
queue.enqueue(newElement: 2)
queue.enqueue(newElement: 3)
queue.display()
queue.dequeue()
queue.display()

// ------------------------------------------------ //

// - MARK: Opaque Types

// ------------------------------------------------ //

protocol Shape: Equatable {
    func describe() -> String
}

struct Square: Shape {
    var color: String
    func describe() -> String {
        return "I'm a square. My four sides have the same lengths."
    }
}

struct Circle: Shape {
    var color: Int
    func describe() -> String {
        return "I'm a circle. I look like a perfectly round apple pie."
    }
}

func makeShape() -> some Shape {
    return Square(color: "Purple")
}

//func incorrectlyMakeShape(isSquareNeeded: Bool) -> some Shape {
//    if isSquareNeeded {
//        return Square(color: "Purple")
//    } else {
//        return Circle(color: 1)
//    }
//}

let aShape = makeShape()
let anotherShape = makeShape()

print(aShape == anotherShape)
// Output: true

// ------------------------------------------------ //

// - MARK: Result Builders

// ------------------------------------------------ //

protocol Drawable {
    func draw() -> String
}

struct Line: Drawable {
    var elements: [Drawable]
    func draw() -> String {
        return elements.map { $0.draw() }.joined(separator: "")
    }
}

struct Text: Drawable {
    var content: String
    init(_ content: String) { self.content = content }
    func draw() -> String { return content }
}

struct Space: Drawable {
    func draw() -> String { return " " }
}

struct Stars: Drawable {
    var length: Int
    func draw() -> String { return String(repeating: "*", count: length) }
}

struct AllCaps: Drawable {
    var content: Drawable
    func draw() -> String { return content.draw().uppercased() }
}

// • Manual building syntax •

let name: String? = "Ravi Patel"
let manualDrawing = Line(elements: [
    Stars(length: 3),
    Text("Hello"),
    Space(),
    AllCaps(content: Text((name ?? "World") + "!")),
    Stars(length: 2),
    ])
print(manualDrawing.draw())
// Prints "***Hello RAVI PATEL!**"

// • `@resultBuilder` powered syntax

@resultBuilder
struct DrawingBuilder {
    static func buildBlock(_ components: Drawable...) -> Drawable {
        return Line(elements: components)
    }
    static func buildEither(first: Drawable) -> Drawable {
        return first
    }
    static func buildEither(second: Drawable) -> Drawable {
        return second
    }
}

func draw(@DrawingBuilder content: () -> Drawable) -> Drawable {
    return content()
}
func caps(@DrawingBuilder content: () -> Drawable) -> Drawable {
    return AllCaps(content: content())
}

func makeGreeting(for name: String? = nil) -> Drawable {
    let greeting = draw {
        Stars(length: 3)
        Text("Hello")
        Space()
        caps {
            if let name = name {
                Text(name + "!")
            } else {
                Text("World!")
            }
        }
        Stars(length: 2)
    }
    return greeting
}
let genericGreeting = makeGreeting()
print(genericGreeting.draw())
// Prints "***Hello WORLD!**"

let personalGreeting = makeGreeting(for: "Ravi Patel")
print(personalGreeting.draw())
// Prints "***Hello RAVI PATEL!**"

// ------------------------------------------------ //

// - MARK: Closures

// ------------------------------------------------ //

// • Syntax •

/*
{ (parameters) -> returnType in
   // statements
}
 */

// • simple version •

var greet = {
  print("Hello, World!")
}

greet()

// • with parameter •

let greetUser = { (name: String)  in
    print("Hey there, \(name).")
}

greetUser("Dauren")

// • returns value •

var findSquare = { (num: Int) -> (Int) in
  let square = num * num
  return square
}

var result = findSquare(3)

print("Square:", result)

// • closure as function parameter •

// define a function and pass closure
func grabLunch(search: () -> ()) {
  print("Let's go out for lunch")

  // closure call
  search()
}

var lunchSearcher = {
    print("Alfredo's Pizza: 2 miles away")
}

// pass closure as a parameter
grabLunch(search: lunchSearcher)

// • trailing closure •

grabLunch {
    print("Alfredo's Pizza: 2 miles away")
}

// • capturing value metaphor •

var guy = "Yerbol"
var partying = { [guy] in
    print("partying in progress...")
    print("nice to meet you, my name is \(guy)")
}
guy = "Ruslan"

partying()


// ------------------------------------------------ //

// - MARK: HOF (higher-order functions)

// ------------------------------------------------ //

struct Book {
    let title: String
    let author: String
    let language: Language
    let pageCount: Int

    enum Language {
        case kazakh
        case russian
        case english
    }
}

let legendaryBooks = [
    Book(title: "Abai Zholy", author: "M. Auezov", language: .kazakh, pageCount: 820),
    Book(title: "Harry Potter", author: "J.K. Rowling", language: .english, pageCount: 417),
    Book(title: "Clean Code", author: "R. Martin", language: .english, pageCount: 280),
    Book(title: "Anna Karenina", author: "L. Tolstoy", language: .russian, pageCount: 756),
    Book(title: "1984", author: "G. Orwell", language: .english, pageCount: 223)
]

// • map – transforming array •

let legendaryAuthors = legendaryBooks.map { book in
    return book.author
}
print(legendaryAuthors)

// • filter •

let englishBooks = legendaryBooks.filter { book in
    book.language == .english
}
print(englishBooks)

// • reduce •

let pageCountSum = legendaryBooks.reduce(0) { sum, book in
    sum + book.pageCount
}
print(pageCountSum)

// • forEach •

legendaryBooks.forEach { legendaryBook in
    print(legendaryBook)
}

// • composing stuff •

let englishBooksTitles = legendaryBooks.filter { $0.language == .english }.map { $0.title }
print(englishBooksTitles)

let kazakhBooksPageCountSum = legendaryBooks.filter { $0.language == .kazakh }.reduce(0) { sum, book in sum + book.pageCount }
print(kazakhBooksPageCountSum)
