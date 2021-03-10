# TriforkSwiftNetworking

## Installation

Supports Swift Package Manager.

## Usage

Here we try to make a simple example for a blog API.

First we need to create a model.

```swift
public struct Post: Codable {
    let id: UUID
    let title: String
    let body: String
}
```

Then we create a `CollectionResponse` as we want to retrive a list of `Post`s.

```swift
public struct PostsResponse: CollectionResponse {
     public typealias OutputType = Post

    public var data: [OutputType]

    public init(input: Data, response: HTTPURLResponse?) throws {
        let decoder = JSONDecoder()

        data = try decoder.decode([Post].self, from: input)
    }
}
```

Finally we create the `Request`. 
The `HTTPRequest` implements most variables as default. The only thing we need to provide is `url`.

```swift
public struct PostsRequest: HTTPRequest {
    public typealias ResponseType = PostsResponse

    public var url: String { "https://myblog/api/posts" }
    public var query: [String : String]? {
        ["category": category]
    }

    private let category: String

    init(category: String) {
        self.catgory = category
    }
}
```

To make a new request, from a `UIViewController` etc we can take a look at the following example

```swift
final class PostsController: UIViewController {
    let networkSession: NetworkSession = URLSession.shared

    var posts = [Post]()

    var anyCancellables = [AnyCancellable]()

    func viewDidLoad() {
        super.viewDidLoad()

        let postsRequest = PostsRequest(category: "dogs")

        networkSession.dataTaskPublisher(for: postsRequest)
            .sink { Error in
                // Handle error
            } receiveValue: { response in
                self.posts = response.data
            }
            .store(in: &anyCancellables)
    }
}
```

In `viewDidLoad` we start with creating the request and then we fetch it with the `NetworkSession`.  
Then we just handle it like a normal things with the Combine framework.


# TSNMockHelpers

The package contains a `TSNMockHelpers` framework, which allows you to mock the `URLSession` when unit testing.

```
let baseUrl = "mock://trifork.com"
let request = TestRequest(
    baseUrl: baseUrl,
    pathComponents: ["test", "mock"],
    method: .get,
    query: nil,
    body: nil,
    headers: nil,
    cachePolicy: .useProtocolCachePolicy
)

let url = URL(string: "\(baseUrl)/test/mock")
URLProtocolMock.data[url] = "MyData".data(using: .utf8)
URLProtocolMock.responses[url] = URLResponseMocks.response(url: url!)

let expect = XCTestExpectation()
session.dataTask(with: request) { (data, response, error) in
    XCTAssertEqual("MyData", String(data: data!, encoding: .utf8))
    XCTAssertNil(error)
    XCTAssertEqual(200, (response as? HTTPURLResponse)?.statusCode)
    expect.fulfill()
}.resume()
wait(for: [expect], timeout: 1.0)
```
