# YMIHere

> Reminder functions for people who juggle lots of terminals

## Usage

Source `ymihere.sh` in your `.bashrc`.

For example, let's say you have downloaded the file and put it into the directory `/home/foo/bar/`. Then you would add the line

```
. /home/foo/bar/ymihere.sh
```

to your `.bashrc`.

Every time you open a new terminal tab you will be asked "why are you here?" and given a shell function to retrieve the answer you gave.

Example:

```shell
Why are you here?

 to demonstrate how ymih works
Okay. Type "ymih" (why am I here) if you need a reminder of
why you have opened this terminal.
$ : doing stuff
$ : someone interrupts me
$ : doing what they asked me to
$ : okay, where was I?
$ 
$ ymih
>>>><<<<<>>>>><<<<<>>>>>  to demonstrate how ymih works <<<<<>>>>><<<<<>>>>><<<<

$ : right
$ ymih + also show the plus feature
$ ymih
>>>><<<<<>>>>><<<<<>>>>>  to demonstrate how ymih works <<<<<>>>>><<<<<>>>>><<<<
                          +   also show the plus feature
```

