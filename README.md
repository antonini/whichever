# whichever
This iOS app (iPhone only) utilizes the [Realm] (https://realm.io/docs/swift/latest/) mobile database to store and persist gender-neutral bathroom data and [Haneke](https://github.com/Haneke/HanekeSwift) to cache images. UNC community members can use the app to view bathroom locations on a map (utilizing [MapBox SDK](https://www.mapbox.com/ios-sdk/)) or they can locate specific information about the bathroom using a search controller. For example, users can obtain the bathroom room number, floor number, availability (public or limited), signage and details. I'm planning to submit the app to UNC for future implementation. The app is meant to be simple for users: Look and Locate.

NB: This project used [Carthage](https://github.com/Carthage/Carthage) to install [Haneke](https://github.com/Haneke/HanekeSwift). The built frameworks were committed, but in case there is an issue you will need to run carthage bootstrap after checking out the project. As Frost (2015) notes, "The **bootstrap** command will download and build the exact versions of your dependencies that are specified in **Cartfile.resolve**...**carthage update**, on the other hand, would update the project to use the newest compatible versions of each dependency, which may not be desirable" ([Carthage Tutorial: Getting Started](https://github.com/josephdhooper/whichever/new/master?readme=1)). 

---

Future iterations. There are a few details I would like to add. One is to add a second table view controller to filter information. The issue I had was making these connections using Realm; I could not get the predicates to work properly. However, the map is usable in its current state.

