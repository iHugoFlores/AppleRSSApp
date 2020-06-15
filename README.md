# Apple RSS App

iPhone app that displays the top 100 albums across all genres using Apple’s RSS generator found here: https://rss.itunes.apple.com/en-us

## Scope

- use Auto Layout
- NOT use storyboards or nibs
- NOT use any third party libraries
- NOT use force unwrapping.
- Have complete Unit Test

## Behaviour

1. On launch, the user should see a UITableView showing one album per cell
   - Each cell should display the name of the album, the artist, and the album art (thumbnail image)
2. Tapping on a cell should push another view controller onto the navigation stack where we see a larger image at the top of the screen and the same information that was shown on the cell, plus genre, release date, and copyright info below the image
   - A button should also be included on this second view that when tapped fast app switches to the album page in the iTunes store
   - The button should be centered horizontally and pinned 20 points from the bottom of the view and 20 points from the leading and trailing edges of the view
   - Unlike the first one, this “detail” view controller should NOT use a UITableView for layout
