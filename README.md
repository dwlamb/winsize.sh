# winsize.sh
The utility wmctrl by Tomáš Stýblo offers numerous ways to manipulate the windows in a Linux GUI-environment.  This is especially helpful to people with neurological conditions that are inhibited from precise mouse control or totally prevented from using a mouse at all.  All facets of manipulating software windows to streamline the use of an X-windows environment are possible.

While wmctrl is well documented, some features I found I just couldn't recall and kept reaching for a cheatsheet.  This bash script alleviates that.  Using bash's built-in getopts to process command line input, winsize.sh processes the input and executes the switch information entered using the syntax wmmctrl expects.  In the case some input is incorrect, the script returns a usage display.

This is my first script submitted to Github.  Comments and forking are welcome

Versions for 32- and 64-bit Ubuntu are available from http://packages.ubuntu.com/precise/x11/wmctrl. A detailed guide and examples are available from http://spiralofhope.com/wmctrl-examples.html
