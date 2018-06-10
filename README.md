# UIPathAutomator
Simple library to automate navigation in a Cocoa Touch app.

---

Have you ever found yourself in a situation where you have to click a lot of buttons, just to get to the one screen you need to work with?

UIPathAutomator can be used to automate these repetitive actions and get to your screen in very little time.

## Features

UIPathAutomator can automate single taps and supports the following locators:
- `UIButton`
  - accessibility identifier
  - title (partial matches are allowed)
- `UIBarButtonItem`
  - accessibility identifier
  - title (partial matches are allowed)
- `UITableViewCell`
  - any text inside (partial matches are allowed)
  - index path
- `UIAlertController`
  - none (dismiss only)

## Usage

Import the framework and add a few lines of code at the end of your AppDelegate's `application(_:, didFinishLaunchingWithOptions:)` method:

```swift

// These actions are executed sequentially
let actions: [Action] = [
 
    // Tap on a button identified by an accessibility id
    ButtonAction.accessibility(id: "view_list_button"),
    
    // Tap on a cell that contains some text
    CellAction.contains(text: "Entry 24"),
    
    // Tap on the back button
    ButtonAction.contains(text: "List"),
    
    // Tap on the cell found at given section and row
    CellAction.index(section: 0, row: 7),
    
    // Tap on the back button
    ButtonAction.contains(text: "List"),
    
    // Tap on the back button
    ButtonAction.contains(text: "Back"),
]
        
let automator = Automator(actions: actions)
automator.start()
```

There is a sample app you can refer to for more information.

# License
UIPathAutomator is released under the MIT license. See [LICENSE](../master/LICENSE) for details.
