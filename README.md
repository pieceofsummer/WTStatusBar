# WTStatusBar

iPhone/iPad status bar with text (and optionally Foursquare-like progress bar) display.

This looks like:

![screenshot](screenshot.png)

## Requirements
iOS5 or later, ARC

## Usage

1. Include `WTStatusBar.h` in your project
2. Call `[WTStatusBar setStatusText:]` or `[WTStatusBar setStatusText: animated:]` when you need to show status information. Progress value is cleared on each setStatusText call.
3. Call `[WTStatusBar setStatusText: timeout: animated:]` if you want to automatically hide status after timeout (like showing information message).
4. Call `[WTStatusBar setProgress:]` or `[WTStatusBar setProgress: animated:]` when you want to change progress bar value. These calls are ignored if status bar is not shown.
5. Call `[WTStatusBar clearStatus]` or `[WTStatusBar clearStatusAnimated:]` when you want to hide status.
6. You may adjust statusbar background color with `[WTStatusBar setBackgroundColor:]`. Color is applied with alpha 0.5 or 1.0, depending on statusbar translucent style.
7. You may adjust text color with `[WTStatusBar setTextColor:]` and progress bar color with `[WTStatusBar setProgressBarColor:]`.

## License
MIT License

Copyright (c) 2013 Alexey Skalozub

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, 
including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH 
THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
