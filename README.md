Record and export a view hierarchy to PNG or JPEG frames for flip book style animations (as used in WatchKit).

# Installation

Simply add this class into your project.

# Usage

## In your Swift code

Create an instance of Recorder and set the view that you wish to record:

```
let recorder = Recorder()
recorder.view = activityIndicator
```

When you are ready to start recording, simply:

```
recorder.start()
```

and when you are finished:

```
recorder.stop()
```

## In your Objective C code

Before start, make sure your `UIViewRecorder` code has been properly integrated in your Objective C project. Refeer to official Apple guide [Swift and Objective-C in the Same Project](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html#//apple_ref/doc/uid/TP40014216-CH10-XID_75) section *Importing Swift into Objective-C*.

Create an instance of Recorder and set the view that you wish to record:

```
Recorder *myRecorder = [[Recorder alloc] init];
myRecorder.view = activityIndicator;
```

When you are ready to start recording, simply:

```
[myRecorder start];
```

and when you are finished:

```
[myRecorder stop];
```

# Output

The console will output some useful information such as:

* Location of the files
* Duration of the recording
* Number of frames

You can specify the output path by setting the `path` property of the recorder. Also, if you would rather have JPGs, set the `outputJPG` property of the recorder to `true`.
