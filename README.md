Arduino keyboard/button project
===============================

The folder doc/ contains this documentation, the schematic files
(schematic.sch created with CADsoft Eagle and exported to .png), and a
PDF file with the HID specification which contains the HID keycode
table.

The folder keyboard/ contains the main Arduino program. It has a main
loop which reads input pins and writes them on the serial port to the
custom keyboard firmware. One thing to note here: the READMASK
constant defines a bitmap mask which defines which 5 input pins
(numbers 2 to 7!!) to read. For the 2-button controller shield, set
this value to 5 to only read pins 2 and 4; for the joystick+button
shield, set this value to 31, to read all inputs from 2 up to 7.

The folder keyboard-firmware/ contains the firmware for the Arduino
UNO which allows it to act as a USB keyboard. It requires the LUFA
library (version 110528). Source code was originally taken from this
page and then adapted to work with a more recent LUFA.
