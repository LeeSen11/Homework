# GameOfLife

A description of this package.


# Assignment 3

## General Instructions

You have been provided with a shell of a SwiftUI application in the Assignment3/SwiftUIGameOfLife directory of the Assignments repository. You are responsible for making this application respond to 3 Tabs and 7 different buttons. You will make things work by a process of progressive disclosure, i.e. each working element will enable some part of the next element to work. So, in most instances, you will need to work the problems in order so that you can go on to the next element.

We will grade first by verifying the function of the application so all features need to operate reasonably.

Your code should of course have no errors or warnings and should make use of the Reducer/State/Action/Environment/Effect framework we have discussed in class.

### Problem 1: GridModel.swift

Equip the `step` action with code which causes GridState, when reduced with the `step` action, to step the grid from one grid state to the next

### Problem 2: SimulationModel.swift

1. Equip the `SimulationState` struct with a variable `isRunningTimer` of type Bool and set it by default to `false`
2. Equip the `SimulationState.Action` enum with a case `resetGridToEmpty` which takes no associated value
3. When the `SimulationState` is reduced via the `resetGridToEmpty` action, set the `state` to have an _empty_ 10x10 `Grid` and return no effects.

### Problem 3: SimulationView.swift

Using the provided `buttonView` function in SimulationView, add a button which has title: `"Empty\nGrid"`, action: `resetGridToEmpty`, and is disabled when the `SimulationState` indicates that the timer is running.

### Problem 4: SimulationModel.swift

1. Equip the `SimulationState.Action` enum with a case `resetGridToRandom` which takes no associated value
2. When the `SimulationState` is reduced via the `resetGridToRandom` action, set the state to have a _random_ 10x10 Grid and return no effects.

### Problem 5: SimulationView.swift

Using the provided `buttonView` function in SimulationView, add a button which has title: `"Random\nGrid"`, action: `resetGridToRandom`, and is disabled when the SimulationState indicates that the timer is running.

### Problem 6: SimulationModel.swift

1. Equip the `SimulationState.Action` enum with a case `tick` which takes no associated value
2. When the `SimulationState` is reduced via the `tick` action:

  1. increment the number of ticks (which is in the `gridState` struct)
  2. step the gridState's grid to its next value and
  3. return no effects.

### Problem 7: SimulationModel.swift

1. Equip the `SimulationState.Action` enum with a case `startTimer` which takes no associated value.
2. When the `SimulationState` is reduced via the `startTimer` action:

  1. set the state's `isRunningTimer` to `true`
  2. prepare a timer Effect which repeatedly fires at 1 second intervals using `env.scheduler` for scheduling.
  3. map the timer effect to the `tick` action
  4. return the mapped effect as a cancellable Effect with id of `SimulationState.Identifiers.simulationCancellable`

### Problem 8: SimulationView.swift

Using the provided `buttonView` function in SimulationView, add a button which has title: `"Start\nTimer`, action: `startTimer`, is disabled when the timer IS running and enabled when it is NOT running. (Note this is opposite of the other buttons in SimulationView)

### Problem 9: SimulationModel.swift

1. Equip the SimulationState.Action enum with a case `stopTimer` which takes no associated value.

2. When the SimulationState is reduced via the `stopTimer` action perform the following:

  1. set the state's `isRunningTimer` to `false` and
  2. return the cancellation Effect with id of `SimulationState.Identifiers.simulationCancellable`

### Problem 10: SimulationView.swift

Using the provided `buttonView` function in SimulationView, add a button which has title: `"Stop\nTimer`, action: `stopTimer`, and is disabled when the timer is NOT running and is enabled when it IS running.

### Problem 11: SimulationModel.swift

1. Equip the SimulationState.Action enum with a case `reset` which takes no associated value.

2. When the SimulationState is reduced via the `reset` action perform the following:

  1. set the grid state's `ticks` value to `0` and
  2. return no effects

### Problem 12: SimulationView.swift

Using the provided `buttonView` function in SimulationView, add a button which has title: `"Reset\nTicks`, action: `reset`, and is disabled when the timer is running.

### Problem 13: SimulationModel.swift

Equip the `simulationReducer` with an additional pullback reducer which operates on

1. SimulationState.gridState
2. SimulationState.Action.grid(action:)
3. SimulationEnvironment.gridEnvironment

### Problem 14: ConfigurationsModel.swift

NB. There are two similarly named files ConfigurationsModel and ConfigurationModel. This problem deals with ConfigurationsModel (the plural one). The objective of this problem is to fetch a JSON file from the internet and parse it when the button is pressed.

1. Equip the ConfigurationsState.Action enum with a case `fetch` which takes no associated value.
2. When the ConfigurationsState is reduced via the `fetch` action perform the following:

  1. set the `isFetching` value to `true`
  2. set configurations to `[]`
  3. create a DataTaskPublisher using the `configUrl` variable and the ConfigurationsState.session static variable
  4. map any errors generated by that publisher to: APIError.urlError(configURL, $0)
  5. tryMap the result of that to: ConfigurationsState.validateHttpResponse
  6. map any errors from the tryMap to an APIError
  7. decode the JSON from the tryMap to type [Grid.Configuration]
  8. replace any errors from the decoding with an empty array
  9. map the decoded values to an action as follows: `.setConfigs($0.map(ConfigurationState.init))`
  10. Make sure to receive all values on the main queue
  11. erase the publisher generated so far to an effect

3. Return the effect as a cancellable with id: `ConfigurationsState.Identifiers.fetchCancellable`

### Problem 15: ConfigurationsModel.swift

NB. This problem deals with ConfigurationsModel (the plural one).

1. Equip the ConfigurationsState.Action enum with a case `cancelFetch` which takes no associated value.
2. When the ConfigurationsState is reduced via the `cancelFetch` action perform the following:

  1. set the `isFetching` value to `false`
  2. return a cancel effect with id: `ConfigurationsState.Identifiers.fetchCancellable`

### Problem 16: ConfigurationsModel.swift

NB. This problem deals with ConfigurationsModel (the plural one).

1. Equip the ConfigurationsState.Action enum with a case `clear` which takes no associated value.
2. When the ConfigurationsState is reduced via the `clear` action perform the following:

  1. set the `isFetching` value to `false`
  2. set the `configs` to an empty array
  3. return a cancel effect with id: `ConfigurationsState.Identifiers.fetchCancellable`

### Problem 17: ConfigurationsView.swift

In the `List { EmptyView() }` view, replace the EmptyView with a ForEachStore which scopes the ConfigurationsView viewStore to:

1. the `configs` state
2. the `configuration(index:action:)`

Provide content to the ForEachStore of a newly init'd ConfigurationView

### Problem 18: ConfigurationsView.swift

In the action of the button labelled "Fetch" send the viewStore the `fetch` action of the ConfigurationsState.Action enum

### Problem 19: ConfigurationsView.swift

In the action of the button labelled "Clear" send the viewStore the `clear` action of the ConfigurationsState.Action enum

### Problem 20: ContentView.swift

Equip the statisticsView function with a tab item which uses the "eyeglasses" system image and the text "Statistics" as a title in a manner similar to the other two tabs.
