Record and export a view hierarchy to PNG or JPEG frames for flip book style animations (as used in WatchKit).

# Installation

Simply add this class into your project.

# Usage

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

# Output

The console will output some useful information such as:

* Location of the files
* Duration of the recording
* Number of frames

You can specify the output path by setting the `path` property of the recorder. Also, if you would rather have JPGs, set the `outputJPG` property of the recorder to `true`.
