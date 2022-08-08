# CodeChallengeJusto
Code Challenge Justo / Jesus Loaiza Herrera


#  Code Challenge


### App

- Launches Past list 

![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-08 at 01 58 36](https://user-images.githubusercontent.com/77905244/183358257-3d4dab2c-9aa4-4db5-a0aa-afc99950edd3.png)


- Details launch

![IMG_0486](https://user-images.githubusercontent.com/77905244/183357809-efa3bc49-b39f-486f-a9ea-65c3abafb9ef.PNG)

- Video launch

![IMG_0487](https://user-images.githubusercontent.com/77905244/183357887-17056e77-d1ff-46dd-a435-24c3e210b957.PNG)

- Info launch

![IMG_0489](https://user-images.githubusercontent.com/77905244/183357945-0c77d117-039b-4242-a922-8a88b00ce8c4.PNG)


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
