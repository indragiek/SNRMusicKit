## SNRMusicKit
### The next generation backbone for music apps on iOS and Mac

SNRMusicKit is an open source project that will become the backbone for [Sonora](http://getsonora.com) and other music applications that we may build for the Mac and iOS platforms. This framework will consist of the following components that will create an all-in-one solution for building content rich music applications:

* **Content Sources**: Services and applications that will provide content. Examples include the iTunes Library on OS X, [MPMediaLibrary](http://developer.apple.com/library/ios/#documentation/mediaplayer/reference/MediaPlayer_Framework/_index.html#//apple_ref/doc/uid/TP40006952) on iOS, as well as streaming services such as [Rdio](http://www.rdio.com) and [8tracks](http://8tracks.com).
* **Players**: Different audio players sharing a common interface to handle a wide variety of content formats. Right now I'm planning to create two players, one based on [AVFoundation](http://developer.apple.com/library/ios/#documentation/AVFoundation/Reference/AVFoundationFramework/_index.html) and another based on [SFBAudioEngine](https://github.com/sbooth/SFBAudioEngine) for handling more obscure formats as well as HTTP streaming. Both frameworks are cross platform.
* **Sharing**: Several methods and services for sharing music content, including posting Now Playing information to Twitter and Facebook, scrobbling on Last.fm, and sharing mixes on 8tracks.
* **Integration**: The framework will provide simple methods of integrating into existing applications on OS X via an AppleScript based API.

All local databases will be **Core Data** SQL databases, in addition to other persistent caching of artwork, etc. All networking code will be built on top of [AFNetworking](https://github.com/AFNetworking/AFNetworking), specifically subclasses of **AFHTTPClient**.

The code and API will be as modern as possible, making use of blocks, GCD, and new Objective-C syntax.  The current goal is to target **OS X 10.7+ and iOS 5.0+** but that may change.

#### Dependencies
SNRMusicKit has several dependencies. To build succelfully you have to install these dependencies and include them in your search path

* flac
* wavpack
* taglib
* libvorbis
* mp4v2

#### Contributing

Once the project is under way, I'd love contributions via pull requests. If you intend on making large additions or changes to the code, you may want to consult with me before beginning to ensure that we both agree that it is suitable for this library. 

#### What's done so far?

I'll try to update this section as frequently as possible. At the moment: **Nothing**. I'm currently preparing for a public beta of Sonora 2, so work on this will only truly begin after that is underway. Right now I've set up a basic Xcode template with targets to create a Mac framework and an iOS static library along with some Core Data boilerplate.

#### License

This library is licensed under the [BSD License](http://opensource.org/licenses/bsd-license.php). All third party libraries used in the project must be licensed under BSD or a similarly unrestrictive license (ie. MIT is acceptable, GPL or any of its variants are not). By making contributions to this project, you are **licensing your own additions under the BSD license as well**. Any contributions licensed under anything else will not be accepted into the master repository (but feel free to keep them in your own fork).