; Right now this is a very basic script I wrote for finishing my guard tower

sleepytime = 250
waitForCraft = 10000
imagefolder = imagesearch/

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
CoordMode, Caret, Screen
CoordMode, Menu, Screen

WinGetPos, winX, winY, winW, winH, ahk_exe WurmLauncher.exe

ImageSearch, craftLegendX, craftLegendY, winX, winY, winX+winW, winY+winH, *TransBlack %imagefolder%crafting.png
ImageSearch, craftTLX, craftTLY, craftLegendX-100, craftLegendY-100, craftLegendX+100, craftLegendY+100, *TransBlack %imagefolder%windowcorner.png
ImageSearch, createX, createY, craftTLX, craftTLY, winX+winW, winY+winH, *TransBlack %imagefolder%continue.png
ImageSearch, craftMaxX, craftMaxY, craftTLX, craftTLY, winX+winW, winY+winH, *TransBlack %imagefolder%craftmax.png
if (not craftTLX or not createX)
    MsgBox, Not able to find crafting window or the create button.

if (not craftMaxX)
    MsgBox, Not able to find max craft button.

StartBuild:

MouseClick, Left, craftMaxX, craftMaxY
sleep %sleepytime%

MouseClick, Left, createX, createY
sleep %waitForCraft%

ImageSearch, stamX, stamY, winX, winY, winX+winW, winY+winH, *TransBlack %imagefolder%stamcorner.png
Loop
    ImageSearch, stamFullX, stamFullY, stamX, stamY, stamX+200, stamY+200, *TransBlack %imagefolder%stamfull.png
Until stamFullX
Goto, StartBuild