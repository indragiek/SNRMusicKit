## SNRMusicKit

SNRMusicKit is an open source project that will become the backbone for [Sonora](http://getsonora.com) and other music applications that we may build for the Mac and iOS platforms. This framework will consist of the following components that will create an all-in-one solution for building content rich music applications:

* **Content Sources**: Services and applications that will provide content.
* **Players**: Different audio players sharing a common interface to handle a wide variety of content formats. 
* **Other Services**: Objective-C interfaces to other commonly used services like Last.fm.

All local databases will be **Core Data** SQL databases, in addition to other persistent caching of artwork, etc. All networking code will be built on top of [AFNetworking](https://github.com/AFNetworking/AFNetworking), specifically subclasses of **AFHTTPClient**.

The code and API will be as modern as possible, making use of blocks, GCD, and new Objective-C syntax.  The current goal is to target **OS X 10.7+ and iOS 5.0+** but that may change.

### Contributing

Once the project is under way, I'd love contributions via pull requests. If you intend on making large additions or changes to the code, you may want to consult with me before beginning to ensure that we both agree that it is suitable for this library. 

### Compiling

* Clone the git repository, and download the submodules using the following commands:

```
cd <repository path>
git submodule init
git submodule update
```

#### Additional Instructions for Mac Framework only
* **SFBAudioEngine** requires some additional frameworks and libraries to compile that are not included in the repository. Download [this](https://github.com/downloads/sbooth/SFBAudioEngine/Frameworks.tar.bz2) archive, extract it, and put the Frameworks folder inside the SFBAudioEngine folder.
* **[mogenerator](https://github.com/rentzsch/mogenerator)** needs to be installed to successfully compile.

### Progress

#### Content Sources

<table>
  <tr>
    <th>Name</th><th>iOS</th><th>Mac</th><th>Implemented</th>
  </tr>
  <tr>
    <td>iTunes</td><td>✘</td><td>✔</td><td>✔</td>
  </tr>
  <tr>
    <td>MPMediaLibrary</td><td>✔</td><td>✘</td><td>✔</td>
  </tr>
  <tr>
    <td>Spotify</td><td>✔</td><td>✔</td><td>✔</td>
  </tr>
</table>

#### Players

<table>
  <tr>
    <th>Name</th><th>iOS</th><th>Mac</th><th>Implemented</th>
  </tr>
  <tr>
    <td>AVQueuePlayer</td><td>✔</td><td>✔</td><td>✔</td>
  </tr>
  <tr>
    <td>SFBAudioEngine</td><td>✔</td><td>✔</td><td>✔</td>
  </tr>
  <tr>
    <td>Spotify SDK</td><td>✔</td><td>✔</td><td>✔</td>
  </tr>
</table>

### Roadmap

#### Short term

* ~~iOS MPMediaLibrary content source implementation~~
* Queue controller for playing a queue of songs
* ~~Cross platform artwork cache~~
* Search protocols & implementation for MPMediaLibrary and Spotify
* ~~Last.fm engine for scrobbling (basically a polished version of SNRLastFMEngine built on AFNetworking)~~

#### Long term

* 8tracks content source implementation

### License

This library is licensed under the [BSD License](http://opensource.org/licenses/bsd-license.php). All third party libraries used in the project must be licensed under BSD or a similarly unrestrictive license (ie. MIT is acceptable, GPL or any of its variants are not). By making contributions to this project, you are **licensing your own additions under the BSD license as well**. Any contributions licensed under anything else will not be accepted into the master repository (but feel free to keep them in your own fork).