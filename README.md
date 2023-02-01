### Star Wars Search

## How to Run

1. Open the Xcode project
2. Pick a target device
3. Click 'Run' (⌘R)

NOTE: If you pick a device other than the simulator, you will likely have to update your provisioning settings.

## How it Works

You can enter a search term in the search bar at the top of the screen. Resources that match your query will appear, containing a list of associated people.

## Room for Improvement

- loading names of people is currently inefficient and sometimes redundant, these could be cached locally.
- search is debounced by 0.1 second to avoid excess queries while typing, but this endpoint is slow and this timing could be tweaked
- more tests!