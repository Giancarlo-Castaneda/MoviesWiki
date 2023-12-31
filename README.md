# MoviesWiki

The goal of this app is to learn about the use of Combine and SwiftUI using the free API provided by The Movie Database (TMDB), you can refer to the [Documentation](https://developer.themoviedb.org/docs/getting-started)

## Defining the Programming Standard

### Commit Message Header

```bash
<type>(<scope>): <summary>
```

The `type` and `summary` fields are mandatory, the `scope` field is optional.

**Type**

Must be one of the following:

- `build`: Changes that affect the build system or external dependencies.
- `ci`: Change to out CI configuration field and scripts.
- `chore`: Maintain code.
- `docs`: Documentation only changes.
- `feat`: A new feature.
- `perf`: A code change that improves performance.
- `refactor`: A code changes that neither fixed a bug nor adds a feature.
- `test`: Adding missing tests or correcting existing tests.
- `style`: Fix a style, formatting, no code change.

**Scope**

The scope should be the name of module or scene, for example: `(feature-flag)`, (`item-add-scene)`

- `module-name`: When the work is in **models**, r**epositories** or **workers**.
- `scene-name`: When the work is in v**iew controllers**, **presenters**, **view models**, data **providers** or **custom views.**

**Summary**

Use the summary field to provide succinct description of the change.

- Use the imperative present tense: `change` not `changed` nor `changes`
- Don't capitalize the first letter
- No dot(.) at the end

**Architecture**

Model-View-ViewModel (MVVM) is a software architecture pattern used to separate the user interface (UI) logic from the business logic or backend logic.

<img src="https://github.com/Giancarlo-Castaneda/MoviesWiki/assets/48701589/9e46cbf5-db87-4ebb-ad5a-09e4bd44fb19" width="800">

## Table of contents

### API

### Models

- Entities
- Models
- Kinds
- Types

### Localizable
- Localizable Strings

### Networking
- NetworkingProvider
- APIError
- RequestType
- ErrorResponse

### Repositories

- Repositories

### ViewModels

- ViewModels

### Views

- Custom Views
- Controllers
- Views

# Swift Style

## Goals

- Make it easier to read and begin understanding unfamiliar code.
- Make code easier to maintain.
- Reduce simple programmer errors.
- Keep discussions on diffs focused on the code's logic rather than its style.

## Table of contents

- Delegates
- Protocol Conformance
- Minimal Import
- Final
- Spacing

### 👉 Delegates

When creating custom delegates methods, an **unnamed first parameter should be the delegate source.**

🟢 **Preferred**

```swift
func inputView(_ inputView: InputView, textDidChange text: String?)
func inputViewShouldReload(_ inputView: InputView) -> Bool
```

🔴 **Not Preferred**

```swift
func didTextChange(inputView: InputView, text: String?)
func inputViewShouldReload() -> Bool
```

### 👉 Protocol Conformance

Protocol Conformance should be performed in a separated extension.

🟢 **Preferred**

```swift
struct MyModel {
    ...
}

// MARK: - Equatable 

extension MyModel: Equatable { }

// MARK: - Codable

extension MyModel: Codable { 
    ...
}
```

🔴 **Not Preferred**

```swift
struct MyModel: Codable, Equatable {
    ...
}
```

### 👉 Minimal Import

Only the modules necessary for the source file should be imported. All source files should import `Foundation`, but don't import `Foundation` when import `UIKit`.

🟢 **Preferred**

```swift
import UIKit

var view = UIView()
var prices: [Double] = []
```

🟢 Preferred

```swift
import Foundation

var prices: [Double] = []
```

🔴 **Not Preferred**

```swift
import Foundation
import UIKit

var view = UIView()
var prices: [Double] = []
```

🔴 **Not Preferred**

```swift
import UIKit

var prices: [Double] = []
```

### 👉 Final

All default classes should be `final` and only in specific cases where inheritance is need should the keyword be removed.

🟢 **Preferred**

```swift
final class MyClass { ... }
```

### 👉 Spacing

- The source code must be indented with 4 spaces.
- Method braces and other braces (`if` / `else` / `swift` / `while`) always open on the same line as the statement but close on a new line.

🟢 **Preferred**

```swift
if user.isEnable {
    ...
} else {
    ...
}

```

🔴 **Not Preferred**

```swift
if user.isEnable
{
    ...
}
else 
{
    ...
}
```

- The `case` statement must not be indented.

🟢 **Preferred**

```swift
switch myKind {
case .optionA:
    ...

case .optionB:
    ...
}
```

🔴 **Not Preferred**

```swift
switch myKind {
    case .optionA:
        ...

    case .optionB:
        ...
}
```

- There should be a blank line between the type declaration to maintain a visual aid.
- Whitespace should be used in the methods to group functionalities.
- There should be no blank line after opening a brace or before closing a brace.
- Colons should not have a space on the left and should have a space on the right.
- Avoid trailing whitespaces at the ends of lines.

- These options should be enabled in Xcode.

<img width="742" src="https://user-images.githubusercontent.com/48701589/200953872-f75fe22e-1d4c-4cc0-bb39-2955668370ba.png">
<img width="742" src="https://user-images.githubusercontent.com/48701589/200953892-0e7c04fc-78d0-4f32-988e-4fe0cd815b8e.png">
<img width="742" src="https://user-images.githubusercontent.com/48701589/200953901-4a67aa61-083c-49a3-aed9-2273f3f49189.png">
