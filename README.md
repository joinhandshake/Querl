# Querl

[![CI Status](https://img.shields.io/travis/joinhandshake/Querl.svg?style=flat)](https://travis-ci.org/joinhandshake/Querl)
[![Version](https://img.shields.io/cocoapods/v/Querl.svg?style=flat)](https://cocoapods.org/pods/Querl)
[![License](https://img.shields.io/cocoapods/l/Querl.svg?style=flat)](https://cocoapods.org/pods/Querl)
[![Platform](https://img.shields.io/cocoapods/p/Querl.svg?style=flat)](https://cocoapods.org/pods/Querl)

Querl is a minimal GraphQL client library. It aims to be agnostic as to the architecture and technology choices of your app. It can be used with any networking stack, and makes no assumptions about how your models are defined. In addition, it is as Swift-y as possible: protocol-oriented, type-safe, and chock full of generics. It has no dependencies, and comprises less than 200 lines of easily auditable code.

Querl is not a GraphQL query construction library. Rather than providing a framework or DSL to build queries at compile-time, Querl expects you to use your preferred testing tool ([Paw](https://paw.cloud), [Postman](https://www.postman.com), [Graphiql](https://github.com/graphql/graphiql), [Insomnia](https://insomnia.rest), and so on) to generate a static `.graphql` file, which Querl reads from disk.

## Features

Querl supports the following GraphQL features:
* Single-model queries
* Mutations
* Paginated queries
* Variables
* Fragments
* Type conditions
* Directives
* Aliasing

It supports those GraphQL features with these Swift language features:
* Composable, extensible query protocols
* Strongly-typed arguments and responses
* Bring your own model types

Querl does *not* (yet) support the following GraphQL features:
* Queries returning multiple top-level models
* Subscriptions

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

The code can be as simple as this:

#### `CountryForCode.graphql`
```
query($code: ID!) {
    country(code: $code) {
        name
    }
}
```
#### `main.swift`
```swift
import Querl

struct CountryForCode: Query, HasArguments {
    struct Response: Decodable {
        let country: Country?
    }
    let code: String
}

let query = CountryForCode(code: "US")
let request = URLRequest(url: graphQLEndpoint)
request.httpMethod = "POST"
request.setValue("application/json", forHTTPHeaderField: "Content-Type")
request.httpBody = try JSONSerialization.data(withJSONObject: query.body)
let (data, _) = try await URLSession.shared.data(for: request)
let country = try CountryForCode.decodeResponse(data).country // "United States of America"
```

This pattern can be easily adapted to Alamofire, or any other networking library that performs `POST` requests.

## Requirements

Querl requires iOS 10.0 or higher. 

## Installation

### CocoaPods

Querl is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Querl'
```

### Swift Package Manager

Declare Querl as a package dependency.
```ruby
.package(
    name: "Querl", 
    url: "https://github.com/joinhandshake/Querl", 
    .upToNextMinor(from: "0.1.0")),
```
Use Querl in target dependencies
```ruby
.product(name: "Querl", package: "Querl")
 ```
## Contributing

See [CONTRIBUTING.md](https://github.com/joinhandshake/.github/blob/main/CONTRIBUTING.md) for more information. Contributions are welcome!

## Code of Conduct

See [CODE_OF_CONDUCT.md](https://github.com/joinhandshake/.github/blob/main/CODE_OF_CONDUCT.md) for more information.

## Author

Joel Kin, open-source@joinhandshake.com, [@foon@mastodon.social](http://mastodon.social/@foon)

## License

Querl is available under the Apache 2.0 license. See the LICENSE file for more info.
