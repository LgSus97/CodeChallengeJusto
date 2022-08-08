# CodeChallengeJusto
Code Challenge Justo / Jesus Loaiza Herrera


#  Code Challenge


### App

- Launches Past list 



### Project Structure

This architecture project is MVVM + coordinator:

    ├─ App
      ├─ Common
      ├─ Modules
      ├─ ViewModel
    ├─ GraphQL
    ├─ Resources


#### External dependencies

- Apollo - Apollo Framework for GraphQL API consumption
- AlamofireImage - for load image from url
- youtube-ios-player-helper - Helper iOS to load videos



### Dependency Management

#### CocoaPods

[CocoaPods][cocoapods] To install pods:

    sudo gem install cocoapods

To get started, move inside iOS project folder and run

    pod init

This creates a Podfile, which will hold all your dependencies in one place. After adding dependencies to the Podfile, you run

    pod install

to install the libraries and include them as part of a workspace which also holds your own project. For reasons stated [here][committing-pods-cocoapods] and [here][committing-pods], we recommend committing the installed dependencies to your own repo, instead of relying on having each developer run `pod install` after a fresh checkout.

Note that from now on, you'll need to open the `.xcworkspace` file instead of `.xcproject`, or your code will not compile. The command

    pod update

will update all pods to the newest versions permitted by the Podfile. You can use a wealth of [operators][cocoapods-pod-syntax] to specify your exact version requirements.

[cocoapods]: https://cocoapods.org/
[cocoapods-pod-syntax]: http://guides.cocoapods.org/syntax/podfile.html#pod
[committing-pods]: https://www.dzombak.com/blog/2014/03/including-pods-in-source-control.html
[committing-pods-cocoapods]: https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control
