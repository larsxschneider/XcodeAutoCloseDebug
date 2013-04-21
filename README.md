# Xcode Auto Close Debug
Xcode plugin that closes the debug window automatically after the debug session has ended.

In response to [this StackOverflow question](http://stackoverflow.com/questions/7212634/xcode-4-1-behaviours-automate-closing-a-tab).

The plugin was developed and tested with Xcode 4.2.1.

## Usage

1. [Download "Xcode Auto Close Debug"](https://github.com/downloads/larsxschneider/XcodeAutoCloseDebug/XcodeAutoCloseDebug.xcplugin.zip)

2. Unzip it.

3. Move `XcodeAutoCloseDebug.xcplugin` to `~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/`

3. Restart Xcode

4. Open menu "Xcode" -> "Preferences" -> "Behaviors" -> "Run Starts".

5. Activate "Show tab" and set the tab name "XcodeAutoCloseDebug" (this exact name is important!)

![Screenshot](XcodeAutoCloseDebug/master/SetupScreenshot.png)

6. Run the executable and detach the debugger window (drag the tab out of Xcode to create an own window).

7. Stop the executable and see what happens ;-)

## Contact

Lars Schneider <larsxschneider+xcodeautoclosedebug@gmail.com>


## License

Xcode Auto Close Debug is available under the BSD license. See the LICENSE file for more info.
