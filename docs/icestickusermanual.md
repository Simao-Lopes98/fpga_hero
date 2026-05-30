iCEstick Evaluation Kit
User’s Guide
August 2013
EB82_01.0

iCEstick Evaluation Kit
Introduction
Thank you for choosing the Lattice Semiconductor iCEstick™ Evaluation Kit.
This guide describes how to start using the iCEstick Evaluation Kit, an easy-to-use USB form factor board for rap-
idly prototyping designs using the iCE40 FPGA. Along with the evaluation board, this kit includes a pre-loaded
design that demonstrates basic board functionality.
The contents of this user’s guide include demo operations, descriptions of the various portions of the evaluation
board, descriptions of the on-board connectors, a complete set of schematics and bill of materials for the iCEstick
Evaluation Board.
Features
The iCEstick Evaluation Kit includes:
(cid:129) iCEstick Evaluation Board – features the following on-board components
– High-performance, low-power iCE40HX1K FPGA
– FTDI 2232H USB device allows iCE device programming and UART interface to a PC
– Vishay TFDU4101 IrDA transceiver
– Five user LEDs
– 2 x 6 position Diligent PmodTM compatible connector enables many other peripheral connections
– Discera 12Mhz MEMS oscillator
– Micron 32Mbit N25Q32 SPI flash
– Supported by Lattice iCEcube2™ design software
– USB connector provides the power supply
– 16 LVCMOS/LVTTL (3.3V) digital I/O connections on 0.1” through-hole connections
(cid:129) Pre-loaded demo design – the kit includes the pre-loaded demo design that flashes the on-board LEDs in a
clockwise pattern.
(cid:129) USB connector – provides a communication and debug port via a USB-to-RS-232 physical channel and pro-
gramming interface to the PC.
Figure 1. iCEstick Evaluation Board
FTDI Lattice Prototyping IrDA
2232H iCE40-1KHX Holes Transceiver
USB
Connector
SPI Pmod
Flash Connector
2

iCEstick Evaluation Kit
Figure 2. iCEstick Functional Block Diagram
USB Type A Male
3
domP ADrI
iCE40
HX1K
144TQFP
ODL
IPS
Pwr LED I/O LEDs
FT2232H
I/O Access
~4 in.

iCEstick Evaluation Kit
Software Requirements
Before using the iCEstick board, download and install the latest version of Lattice iCEcube2™ and Diamond Pro-
grammer. Make sure you log in to the Lattice website, otherwise these software downloads will not be visible.
These are available at http://www.latticesemi.com/Products/DesignSoftwareAndIP.aspx. If you install Diamond
Programmer 2.2, you will require a software patch. This software patch is available at http://www.lattice-
semi.com/icestick. Go to the Downloads tab and install the appropriate patch. This patch is not required with Dia-
mond Programmer 3.0 or higher.
Figure 3. Software Downloads
Download
iCEcube2
for HDL
development
Download Diamond
Programmer for
physically configuring
the device
4

iCEstick Evaluation Kit
Communication Between the PC and iCEstick
Communication between the iCEstick Board and a PC is via the FTDI 2232H USB device. To enable this connec-
tion the installation of the FTDI chip USB hardware drivers is needed. This driver is installed when Diamond Pro-
grammer was installed. These drivers enable the computer to recognize and program the iCEstick board. In
addition these drivers allow communication between the PC and the iCEstick board to enable further demonstra-
tions.
Connecting the iCEstick Evaluation Board
Insert the iCEstick evaluation board to an open USB slot in a PC. The default bitstream in the SPI flash loads the
iCE40HX-1k device on the iCEstick board. One should see the green LED on the board light up and continue to be
lit.
Preprogrammed Design and Board LEDs
There are a total of 5 LEDs on the iCEstick board. All are controlled by I/Os of the iCE40HX-1k device. The default
bitstream loads the iCE40HX-1k device and the green LED lights up signifying that the device has loaded correctly
and power is good. The other four red LEDs arranged in a diamond pattern begins to flash in a clockwise direction.
This is the intended function of the default bitstream.
Table 1. User I/O and LEDs
LED location CPLD pin (All in Bank 1) CPLD I/O LED color
D1 99 PIO1_14 Red
D2 98 PIO1_13 Red
D3 97 PIO1_12 Red
D4 96 PIO1_11 Red
D5 95 PIO1_10 Green
Download Demo Designs
The above demo is pre-programmed into the iCEstick board. Other than the default design, Lattice also distributes
source and programming files for demonstration designs compatible with this board. To download the demo
designs:
1. Browse to www.latticesemi.com/icestick and click on the Downloads tab to view other design files and capabil-
ities that the iCEstick board could implement. Various demo designs are available and can be download.
2. Extract the contents of zip files to a local hard drive.
Lattice provides the following demos based on iCEstick board:
(cid:129) UART over IrDA. In this demo design, the iCEstick device communicates with a laptop or PC through UART over
USB. Then, the payload is transmitted through Vishay IrDA device. This data can be locally looped back or
another iCEstick board could receive the data via it’s IrDA receiver.
(cid:129) Diligent Pmod Accelerometer. The demo makes use of Digilent PmodAcl module which is plugged into iCEstick
board. In this demo design, the accelerometer setting and reading is done by the on-board iCE device and the
direction of movement is displayed with the diamond pattern LEDs.
5

iCEstick Evaluation Kit
IrDA Functionality and Demo
The iCEstick board has a Vishay TFDU4101 IrDA transceiver on it. This device allows transmit and receive of infra-
red data up to 115kbps.
Table 2. IrDA Pin Description
IrDA function CPLD pin CPLD I/O Comment
RXD 106 PIO1_19 Receive data pin
TXD 105 PIO1_18 Transmit data pin
SD 107 PIO1_20 Shut down
There are two possible configurations for the IrDA demo design: IrDA TX and IrDA RX. For an end to end complete
IrDA link demo, two iCEstick boards are needed, however using just the IrDA Tx design can support a demo. The
IrDA TX design transfers the data from the PC keyboard input in a terminal window to the IrDA Vishay device TXD.
While the data is transmitted via infrared, it is also by default looped back to the receive channel of the IrDA device.
In this demo the looped back data is received and before it is transmitted to the PC window the text is converted
from lower case to upper case. This is the signal flow for the stand alone demo.
Figure 4. IrDA TX on iCEstick
IrDA TX
UART
iCE40
via USB
Laptop or PC
The IrDA RX design receives infrared data from the Vishay IrDA Tx device. After the IrDA data is wirelessly
received it is then sent to the iCE40 device. The iCE40 then send the character information to the open window on
the PC. Thus whatever is typed in the TX terminal window is displayed in the Rx terminal window.
Figure 5. IrDA RX on iCEstick
UART
iCE40 Vishay IrDA
Over
USB
Laptop or PC
This demo requires a terminal program on PC to communicate with the iCEstick board. The following instructions
describe the setup for IrDA TX stand alone demo using the Tera Term terminal emulator program on Windows 7.
6

iCEstick Evaluation Kit
Setting Up for the IrDA TX Stand Alone Demo
To set up for the IrDA TX demo:
1. Program the iCE device with IrDA TX bitstream.
2. Plug iCEstick into a PC USB port.
3. Check if the USB driver is installed correctly.
Go to Start, right-click Computer and select Properties. The System window is shown.
Click Device Manager.
Figure 6. System Window
4. If the driver is installed correctly, the device is listed without an error tag under Ports (COM & LPT) as shown in
Figure 7. Proceed to the next step.
Figure 7. Device Manager
7

iCEstick Evaluation Kit
If the driver is not installed correctly, the device is tagged with a yellow exclamation point as shown in Figure 8.
You need to install the driver. To do this, right-click the device and select Update Driver Software.
Figure 8. Device Manager with Driver Error
Request Windows to search the web for the driver. After Windows locates the FTDI driver, install it and proceed
to the next step.
5. Install Tera Term software. The installer can be downloaded from http://download.cnet.com/Tera-Term/3000-
20432_4-75766675.html.
6. Open Tera Term.
7. In the New connection dialog box, click Serial.
8. On the Port menu, click COMxx: USB Serial Port (COMxx). If there are two or more options, select the last
COM port on the list. Click OK.
Figure 9. New Connection Dialog Box
9. The selected COM port/default baud rate appear in the Tera Term VT window title bar as shown in Figure 10.
On the Setup menu, click Serial port.
8

iCEstick Evaluation Kit
Figure 10. Tera Term VT Window with Selected COM Port /Default Baud Rate
10. The Serial port setup dialog box opens. In the Baud rate menu, click 115200. Leave other options with default
settings. Click OK.
Figure 11. Serial Port Setup Dialog Box
11. The selected COM port/115200 baud rate appear in the Tera Term VT window title bar as shown in Figure 12.
On the Setup menu, click Terminal.
9

iCEstick Evaluation Kit
Figure 12. Tera Term VT Window with Selected COM Port /Baud Rate
12. The Terminal setup dialog box opens. Select Local echo. Leave other options with default value. Click OK.
Figure 13. Terminal Setup Dialog Box
When you type in the Tera Term VT window using the TX design, a lower case character is echoed with a capital
character from the iCE device as shown in the Figure 14.
10

iCEstick Evaluation Kit
Figure 14. Tera Term VT Window Using TX Design
For IrDA RX, the above Tera Term setting is the same but the bitstream for the iCE device is different. With a setup
of two iCEstick boards facing each other, one programmed with IrDA TX and the other programmed with IrDA RX,
the character typed in IrDA TX PC is transferred to and displayed on IrDA RX PC monitor. You can change the
angle of the TX board facing the RX board to see when the IrDA link would break.
11

iCEstick Evaluation Kit
Diligent Pmod Connector and Accelerometer Demo
On the iCEstick board, location J2 is a 2x6 position Pmod (Peripheral MODule) Digilent connector. The iCEstick
board supports a variety of Pmod peripheral modules for easy I/O expansion. Figure 3 lists the 0.1” through-hole
headers on the iCEstick board that support Pmod modules. Pmod modules come in different form factors, and
each Pmod header includes power and ground supplies. The easiest way to support a Pmod module is to add the
appropriate female socket. Straight-through or right-angle connectors can be used. Male headers are an alternate
solution when using the interface cable provided with most Pmod modules.
Table 3. Diligent Pmod Compatible Connector Description
| Connection | Left Row pins  | Right Row pins |     | Connection |
| ---------- | -------------- | -------------- | --- | ---------- |
| PIO1_02    | 1              |                | 7   | PIO1_06    |
| PIO1_03    | 2              |                | 8   | PIO1_07    |
| PIO1_04    | 3              |                | 9   | PIO1_08    |
| PIO1_05    | 4              |                | 10  | PIO1_09    |
| Ground     | 5              |                | 11  | Ground     |
| 3.3v       | 6              |                | 12  | 3.3v       |
The Accelerometer demo makes use of the Digilent PmodAcl accelerometer module from Diligent. The PmodAcl
module needs to be plugged into J2 on the iCEstick board through the cable that comes with this module. The four
LEDs D1, D2, D3 and D4 in the north, south, east and west pattern are configured to represent X+, Z+, X-, Z- of
accelerometer movement direction respectively. When the accelerometer module is moved around, the diamond
pattern LEDs on the iCEstick board goes on/off corresponding to the direction of the movement and orientation of
the module. If all these LEDs light up at the same time (indicating a balance point), The D5 LED also lights up.
Figure 15. Accelerometer Demo on iCEstick
| Acl Module |     | iCE40 |     | LED |
| ---------- | --- | ----- | --- | --- |
Accelerometer Demo on iCEstick
12

Programming Demo Designs with Lattice Programmer
To program a bitstream file to iCE device:
1. Plug the iCEstick board to a USB port on a host PC with Programmer installed.
2. Run Programmer. The Diamond Programmer Getting Started window opens. Under Select an Action, click
Create a new Blank Project. Click OK. If you try to create a new project from a scan, you will receive an error.
Please select Create a new Blank Project.
Figure 16. Diamond Programmer Getting Started Window
3. The Diamond Programmer interface opens. Under Cable Settings, in the Cable menu, click USB2. In the Port
menu, click FTUSB-0. You can also click Detect Cable to set the correct cable and port.
Figure 17. Cable and Port Settings
4. Select the Enable check box.
5. Double-click the cell under Device Family and click iCE40.

Figure 18. Device Family Options
6. Double-click the cell under Device and click iCE40HX1K.
Figure 19. Device Options
7. Double-click the cell under Operation. The Device Properties dialog box opens as shown in Figure 20. On the
Access Mode menu, click SPI Flash Programming. Click OK.

Warning: NVCM Programming is NOT recommended. NVCM Programming is one time programming. If you
use NVCM Programming to program iCE device, the iCE device can no longer be reprogrammed.

Figure 20. Device Properties Dialog Box
8. Select the SPI flash part number. For the iCEstick, this is Micron SPI-N25Q032 8-pin VDFPN8 package. Also
make sure to select the programming file. Once done, click OK.
Figure 21. Select Serial SPI Flash
9. On the Programmer toolbar, click the Program button to initiate the download. The bitstream starts download-
ing to the iCE device. This takes a few seconds to complete.

Expansion I/O Connections
The iCEstick board contains two unpopulated 0.1” headers for users to implement their own connections. Connec-
tors J1 and J3 each consist of 10 positions for a total of 20 connections. Two of these are tied to 3.3v and two are
tied to ground. This leaves 16 general purpose I/Os that connect to the iCE40HX-1k device for user I/O.
Table 4. Expansion I/O Connections
|     | J1 Connector    |         |     |          |     |     | J3 Connector    |          |
| --- | --------------- | ------- | --- | -------- | --- | --- | --------------- | -------- |
| Pin | CPLD I/O Bank 0 |         |     | CPLD Pin | Pin |     | CPLD I/O Bank 2 | CPLD Pin |
| 1   |                 | 3.3v    |     | -        | 1   |     | 3.3v            | -        |
| 2   |                 | Ground  |     | -        | 2   |     | Ground          | -        |
| 3   |                 | PIO0_02 |     | 112      | 3   |     | PIO2_17         | 62       |
| 4   |                 | PIO0_03 |     | 113      | 4   |     | PIO2_16         | 61       |
| 5   |                 | PIO0_04 |     | 114      | 5   |     | PIO2_15         | 60       |
| 6   |                 | PIO0_05 |     | 115      | 6   |     | PIO2_14         | 56       |
| 7   |                 | PIO0_06 |     | 116      | 7   |     | PIO2_13         | 48       |
| 8   |                 | PIO0_07 |     | 117      | 8   |     | PIO2_12         | 47       |
| 9   |                 | PIO0_08 |     | 118      | 9   |     | PIO2_11         | 45       |
| 10  |                 | PIO0_09 |     | 119      | 10  |     | PIO2_10         | 44       |
Test Points
There are three unpopulated test points. TP1 is tied to 3.3v, TP2 is tied to 1.2v and TP3 is connected to ground.
Lattice Demonstration Bitstreams
All demonstration bitstreams and Design files are available at www.latticesemi.com/icestick.
Technical Support Assistance
e-mail: techsupport@latticesemi.com
Internet: www.latticesemi.com
Revision History
| Date        |     |     | Version |                  |     | Change Summary |     |     |
| ----------- | --- | --- | ------- | ---------------- | --- | -------------- | --- | --- |
| August 2013 |     |     | 01.0    | Initial release. |     |                |     |     |
© 2013 Lattice Semiconductor Corp. All Lattice trademarks, registered trademarks, patents, and disclaimers are as
listed at www.latticesemi.com/legal. All other brand or product names are trademarks or registered trademarks of
their respective holders. The specifications and information herein are subject to change without notice.

Appendix A. Schematic Diagrams
|     | D   | C   | B   | A   |     |
| --- | --- | --- | --- | --- | --- |
vvveeeRRR AAA
555
fffooo
mmmaaarrrgggaaaiiiDDD   kkkcccooolllBBB   ---   tttiiiKKK   nnnoooiiitttaaauuulllaaavvvEEE   kkkccciiitttsssEEECCCiii
111
ttteeeeeehhhSSS
| 1   |     |     |     |     | 1   |
| --- | --- | --- | --- | --- | --- |
NNNVVVEEE---KKKCCCIIITTTSSS---KKK111XXXHHH000444EEECCCIII
REDAEH
SSSYYYSSSLLLEEEXXXAAA
rrreeebbbmmmuuuNNN   tttnnneeemmmuuucccoooDDD
333111000222   ,,,222111   rrrpppAAA
SDEL sO/I
|     |     |     |     |     | eeezzziiiSSS :::eeetttaaaDDD |
| --- | --- | --- | --- | --- | ---------------------------- |
eeellltttiiiTTT BBB
|     |     | 1 KNAB | IPS |     |     |
| --- | --- | ------ | --- | --- | --- |
441QT-K1XH-04ECi
| 2   |     |     | sO/I |     | 2   |
| --- | --- | --- | ---- | --- | --- |
2 KNAB REDAEH
0 KNAB AGPF
REDAEH
sO/I
BANK 3
232SR
sO/I
| 3   |     |     |     |     | 3   |
| --- | --- | --- | --- | --- | --- |
REDAEH
V5 BSU morf rewoP
| 4   |     |     |     |     | 4   |
| --- | --- | --- | --- | --- | --- |
232SR / IPS
 ot BSU
ROTCENNOC
| 5   |     |     |     |     | 5   |
| --- | --- | --- | --- | --- | --- |
BSU
|     | D   | C   | B   | A   |     |
| --- | --- | --- | --- | --- | --- |

|     | D   |     |     |     | C   |     |     | B   |     | A   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
vvveeeRRR AAA
555
222333222SSSRRR///IIIPPPSSS   ooottt   BBBSSSUUU   ---   tttiiiKKK   nnnoooiiitttaaauuulllaaavvvEEE   kkkccciiitttsssEEECCCiii
fffooo
222
| 1   |     |     |     |     |         |     |         |       |     |     | ttteeeeeehhhSSS 1                                         |
| --- | --- | --- | --- | --- | ------- | --- | ------- | ----- | --- | --- | --------------------------------------------------------- |
|     |     |     |     |     |         |     | 4 4 4 4 | 4 4 4 |     |     |                                                           |
|     |     |     |     | 4 4 | 4 4 4 4 |     |         |       |     |     | NNNVVVEEE---KKKCCCIIITTTSSS---KKK111XXXHHH000444EEECCCIII |
L T L T
|     |     |     |     | I                | O B E N T S       |     | T _ T _ x                     |             |     |                       |                                                                                    |
| --- | --- | --- | --- | ---------------- | ----------------- | --- | ----------------------------- | ----------- | --- | --------------------- | ---------------------------------------------------------------------------------- |
|     |     |     |     | K C S O          | S _ S O D E R     |     | x R _ T _                     |             |     |                       |                                                                                    |
|     |     |     |     | S _ M _          | I M _ S _ C _ C _ |     | 2 3 2 3 n n S                 | n n R n D   |     |                       |                                                                                    |
|     |     |     |     | E C E C          | E C E C E C E C   |     | 2 S 2 S R S T T C             | R T S D C D |     |                       |                                                                                    |
|     |     |     |     | i i              | i i i i           |     | R R                           | D           |     | SSSYYYSSSLLLEEEXXXAAA |                                                                                    |
|     |     |     |     |                  |                   |     |                               |             |     |                       | rrreeebbbmmmuuuNNN   tttnnneeemmmuuucccoooDDD 333111000222   ,,,222111   rrrpppAAA |
|     |     |     |     |                  | 4444RR 5544RR     |     | 00 11 22 33 44                | 66 77       |     |                       |                                                                                    |
|     |     |     |     | 11RR 22 RR 33 RR | 44 RR             |     | 11 RR 11 RR 11 RR 11 RR 11 RR | 11 RR 11 RR |     |                       |                                                                                    |
:::eeetttaaaDDD
eeellltttiiiTTT eeezzziiiSSS BBB
|     |     |          |     | 00 00 00                  | 00 00 00                |                             | 00 00 00 00 00      | 00 00                   |                                                  |     |     |
| --- | --- | -------- | --- | ------------------------- | ----------------------- | --------------------------- | ------------------- | ----------------------- | ------------------------------------------------ | --- | --- |
|     |     |          |     | K C O                     | S                       |                             |                     |                         |                                                  |     |     |
|     |     |          |     | S I S S                   | S                       |                             |                     |                         |                                                  |     |     |
| 2   |     |          |     |                           |                         |                             |                     |                         |                                                  |     | 2   |
|     |     |          |     | 6 7 8                     | 9 1 2 3 4               | 6 7 8 9 0 2 3               | 4 8 9 0 1 3         | 4 5 6 8 2               | 3 4 5 7 8 9 06 63                                |     |     |
|     |     |          |     | 1 1 1                     | 1 2 2 2 2               | 2 2 2 2 3 3 3               | 3 3 3 4 4 4         | 4 4 4 4 5               | 5 5 5 5 5 5                                      |     |     |
|     |     | V3.3+    |     | 0 1                       | 2 3 4 5 6 7             | 0 1 2 3 4 5 6               | 7 0 1 2 3           | 4 5 6 7 0 1             | 2 3 4 5 6 7 #NERWP #DNEPSUS                      |     |     |
|     |     |          | 6   | 5 O I C C V S U S U       | S U S U S U S U S U S U | S U S U S U S U S U S U S U | S U S U S U S U S U | S U S U S U S U S U S U | S U S U S U S U S U S U                          |     |     |
|     |     |          | 2   | 4 O I C C V B D B D       | B D B D B D B D B D B D | B C B C B C B C B C B C B C | B C B D B D B D B D | B D B D B D B D B C B C | B C B C B C B C B C B C                          |     |     |
|     |     |          | 1   | 3 O O I I C C C C V V A A | A A A A A A             | A A A A A A A               | A B B B B           | B B B B B B             | B B B B B B D D N N G G 1 5                      |     |     |
|     |     | TF8_1CCV | 0   | 2                         |                         |                             |                     |                         | BBSSUU  ddeeeeppSS--hhggiiHH  IIDDTTFF D N G 7 4 |     |     |
D N G 5 3
|     |     |     | 4   | 6 E R O C V |     |     |     |     | D N G 5 5 1 2                                    |     |     |
| --- | --- | --- | --- | ----------- | --- | --- | --- | --- | ------------------------------------------------ | --- | --- |
|     |     |     | 7   | 3 E R O C V |     |     |     |     | D N G 1 1                                        |     |     |
|     |     |     | 2   | 1 E R O C V |     |     |     |     | HH22332222TTFF                     D D N N G G 5 |     |     |
|     |     |     |     | L L P V     |     |     |     |     | 1                                                |     |     |
|     |     |     |     | 9 4 Y H P V |     |     |     |     | D N G A 0 1                                      |     |     |
TU
|     |     |     |                  | N     | O           | #TESER | AT            |         |      |     |     |
| --- | --- | --- | ---------------- | ----- | ----------- | ------ | ------------- | ------- | ---- | --- | --- |
|     |     |     |                  | I G E | G E         |        | S C K L C A D | IC OCSO | TSET |     |     |
|     |     |     | LLHH22332222TTFF | R V   | R V M D P D | FER    | E E E E E E   | S O     |      |     |     |
|     |     |     | 11UU             | 0 5   | 9 4 7 8     | 41 6   | 3 6 2 6 1 6 2 | 3       | 31   |     |     |
4
M D P D
K AT
| 3   |     |     |     |     | 5 5 | KK22..22 KK2211 | S C L C A D |     | KLC_ECi |     | 3   |
| --- | --- | --- | --- | --- | --- | --------------- | ----------- | --- | ------- | --- | --- |
E E E E E E
|     | FFuu11..00 | FFuu11..00 |       |     |     |           | _ T _ T _ T |     |            |     |     |
| --- | ---------- | ---------- | ----- | --- | --- | --------- | ----------- | --- | ---------- | --- | --- |
|     | 22CC       | 44CC       |       |     |     | 55RR 66RR | F F F       |     |            |     |     |
|     | FFuu77..44 | FFuu77..44 | V3.3+ |     |     |           |             |     | FFuu11..00 |     |     |
|     | 11CC       | 33CC       |       |     |     |           |             |     | 3311CC     |     |     |
8811RR
00
V3.3+
FFuu11..00
1111CC
4 3
DDV TUPTUO
ZZHHMM00000000..2211
|       |       |     | TF8_1CCV |     |     | 0011CC FFuu0011 |     |     |               |     |     |
| ----- | ----- | --- | -------- | --- | --- | --------------- | --- | --- | ------------- | --- | --- |
|       |       |     |          |     |     |                 |     |     | 11XX #YBDNATS |     |     |
| V3.3+ | V3.3+ |     |          |     |     |                 |     |     |               |     |     |
DNG
1 2
| 4   |     |     |     |            |     |     |          |     |     |     | 4   |
| --- | --- | --- | --- | ---------- | --- | --- | -------- | --- | --- | --- | --- |
|     |     |     |     | FFuu11..00 |     |     | KK22..22 |     |     |     |     |
99CC
5511RR
KK0011
99RR
FFuu11..00
|     |     |     |     | 88CC |     | 88RR KK0011 |     |     |     |     |     |
| --- | --- | --- | --- | ---- | --- | ----------- | --- | --- | --- | --- | --- |
KK0011
|     |     |     |     |     | V3.3+ | 77RR |     |     |     |     |     |
| --- | --- | --- | --- | --- | ----- | ---- | --- | --- | --- | --- | --- |
FFuu11..00
55CC
1 2 3 4
S C K L I D O D 88
C OO SS--
|     |     |     |     | FFuu11..00 |     | 22 UU | C G 66 55               |     |     |     |     |
| --- | --- | --- | --- | ---------- | --- | ----- | ----------------------- | --- | --- | --- | --- |
|     |     |     |     | 77CC       |     |       | C V U N R O S S V CC LL |     |     |     |     |
3399
| 5   |     |     |     |            |     |       | 8 7 6 5 |     |     |     | 5   |
| --- | --- | --- | --- | ---------- | --- | ----- | ------- | --- | --- | --- | --- |
|     |     |     |     | FFuu11..00 |     | V3.3+ |         |     |     |     |     |
66CC
|     |     |     | V3.3+ |     |     |     |     | FFuu |     |     |     |
| --- | --- | --- | ----- | --- | --- | --- | --- | ---- | --- | --- | --- |
22 11 CC 11 ..
00
|     | D   |     |     |     | C   |     |     | B   |     | A   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

|     | D   |     | C   |     | B   |     | A   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
vvveeeRRR AAA
555
fffooo
33RRTT--11001144UUDDFFTT
333
AAAGGGPPPFFF   ---   tttiiiKKK   nnnoooiiitttaaauuulllaaavvvEEE   kkkccciiitttsssEEECCCiii
|     |     | 2 1       | D C D              |     |     |     |     |                                                           |
| --- | --- | --------- | ------------------ | --- | --- | --- | --- | --------------------------------------------------------- |
| 1   |     | C C C C   | N C E R D X DXR DS |     |     |     |     | ttteeeeeehhhSSS 1                                         |
|     |     | 44 UU V V | G N I T            |     |     |     |     |                                                           |
|     |     | 1 6       | 8 7 2 3 4 5        |     |     |     |     | NNNVVVEEE---KKKCCCIIITTTSSS---KKK111XXXHHH000444EEECCCIII |
0022
RR 77 44
FFuu
|     |       | 99 11 77 88 11 11 .. |     |     |     |     |                       |                                                                                    |
| --- | ----- | -------------------- | --- | --- | --- | --- | --------------------- | ---------------------------------------------------------------------------------- |
|     | V3.3+ | RR 44 CC 00          |     |     |     |     | SSSYYYSSSLLLEEEXXXAAA |                                                                                    |
|     |       |                      |     |     |     |     |                       | rrreeebbbmmmuuuNNN   tttnnneeemmmuuucccoooDDD 333111000222   ,,,222111   rrrpppAAA |
99 11 FFuu 77
CC .. 44
|     |     | 5 5 5 5 5 |     |     |     |     |     | :::eeetttaaaDDD |
| --- | --- | --------- | --- | --- | --- | --- | --- | --------------- |
eeellltttiiiTTT eeezzziiiSSS BBB
4 D 3 D 2 D 1 D 0 D
E L E L E L E L E L
|     | 2 3 4 5                 | 6 7 8 9                 |     |     |                   |     |     |     |
| --- | ----------------------- | ----------------------- | --- | --- | ----------------- | --- | --- | --- |
|     | 0 _ 0 _ 0 _ 0 _         | 0 _ 0 _ 0 _ 0 _         |     |     | 0022CC FFuu11..00 |     |     |     |
|     | 1 O I 1 O I 1 O I 1 O I | 1 O I 1 O I 1 O I 1 O I |     |     | V3.3+             |     |     |     |
| 2   | P P P P                 | P P P P                 |     |     |                   |     |     | 2   |
60_1OIP 70_1OIP 80_1OIP 90_1OIP
|     |                 | 1 2                                         | 4 5 6 7         |     |     |     |     |     |
| --- | --------------- | ------------------------------------------- | --------------- | --- | --- | --- | --- | --- |
|     | 8 7 9 7 0 8 1 8 | 7 8 8 8 0 9 1 9 5 9 6 9 7 9 8 9 9 9 0 1 0 1 | 0 1 0 1 0 1 0 1 |     |     |     |     |     |
hhgg
|     | 2 0 3 0 4 0       | 5 0 6 0 7 0 8 0 9 0 0 1 1 1 2 1 3 1 4 1 5 1 6 1                         | 7 1 8 1 9 1 0 2 uu oo              |       |          |     |     |     |
| --- | ----------------- | ----------------------------------------------------------------------- | ---------------------------------- | ----- | -------- | --- | --- | --- |
|     | _ 1 O _ 1 O _ 1 O | _ 1 O _ 1 O _ 1 O _ 1 O _ 1 O _ 1 O _ 1 O _ 1 O _ 1 O _ 1 O _ 1 O _ 1 O | _ 1 O _ 1 O _ 1 O _ 1 O rr hh tt   |       | 01 11 21 |     |     |     |
|     | I P I P I P       | I P I P I P I P I P I P I P I P I P I P I P I P                         | I P I P I P I P ddeettuuoorr       | 7 8 9 |          |     |     |     |
6x2 domP
|     | 444411QQTT--KK11XXHH0044EECCii | 11                              |                        | 22JJ                    |         |     |     |     |
| --- | ------------------------------ | ------------------------------- | ---------------------- | ----------------------- | ------- | --- | --- | --- |
|     |                                |                                 | 0 0 1 0    ee bb       |                         |         |     |     |     |
|     | 1 2                            | KK NN K C I D O D S M           | _ 1 _ 1    yy          | 1 2 3                   | 4 5 6   |     |     |     |
|     | 0 _ 0 _                        | AA T / 1 T / 2 T / 3 T / 4      | O I P O I P aa mm      |                         |         |     |     |     |
|     | 1 O 1 O                        | BB 5 6 7 8 2 _ 2 _ 2 _ 2 _      | B _ T / 2 / 3    ss nn |                         |         |     |     |     |
|     | BB33UU I C C I C C             | _ C _ C _ C _ C 1 O 1 O 1 O 1 O | S R N I B N I B ii pp  |                         |         |     |     |     |
|     | V V                            | N N N N I P I P I P I P         | T G G    CCNN          |                         |         |     |     |     |
|     | 9 0                            | 2 3 4 5 5 3 6 4                 | 7 4 3                  | 20_1OIP 30_1OIP 40_1OIP | 50_1OIP |     |     |     |
|     | 8 01                           | 8 8 8 8 7 7 7 7                 | 7 9 9                  |                         |         |     |     |     |
11 22 RR KK 00 11
FFuu
77 11 11
CC .. 00
| 3   |     |     |     |     |     |     |     | 3   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
66 11 FFuu 11
V3.3+ CC .. 00
|     | 2 0 _ 3 0 _ 4 0 _ 5 0 _ | 6 0 _ 7 0 _ 8 0 _ 9 0 _                     |                         |         |                                                 |         |     |     |
| --- | ----------------------- | ------------------------------------------- | ----------------------- | ------- | ----------------------------------------------- | ------- | --- | --- |
|     | 0 O 0 O 0 O 0 O         | 0 O 0 O 0 O 0 O                             |                         | V3.3+   |                                                 |         |     |     |
|     | I P I P I P I P         | I P I P I P I P                             |                         |         |                                                 |         |     |     |
|     |                         |                                             |                         | 20_0OIP | 30_0OIP 40_0OIP 50_0OIP 60_0OIP 70_0OIP 80_0OIP | 90_0OIP |     |     |
|     | 2 1 3 1 4 1 5 1         | 6 1 7 1 8 1 9 1 0 2 1 2 2 2 4 3 5 3 6 3 7 3 | 8 3 9 3 1 4 2 4 3 4 4 4 |         |                                                 |         |     |     |
4 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 hhgguuoorrhhtt  ddeettuuoorr  eebb  yyaamm  ssnniipp  CCNN 4
|     | 2 0 3 0 4 0       | 5 0 6 0 7 0 8 0 9 0 0 1 1 1 2 1 3 1 4 1 5 1 6 1                         | 7 1 8 1 9 1 0 2 1 2 2 2             |     |     |                                      |     |     |
| --- | ----------------- | ----------------------------------------------------------------------- | ----------------------------------- | --- | --- | ------------------------------------ | --- | --- |
|     | _ 0 _ 0 _ 0       | _ 0 _ 0 _ 0 _ 0 _ 0 _ 0 _ 0 _ 0 _ 0 _ 0 _ 0 _ 0                         | _ 0 _ 0 _ 0 _ 0 _ 0 _ 0             |     |     |                                      |     |     |
|     | O I P O I P O I P | O I P O I P O I P O I P O I P O I P O I P O I P O I P O I P O I P O I P | O I P O I P O I P O I P O I P O I P |     |     | 0011xx11  rreeddaaeehh  eellaammeeFF |     |     |
01
|     |                                |                   |                         | 1 2 3 | 4 5 6 7 8 9 |        |     |     |
| --- | ------------------------------ | ----------------- | ----------------------- | ----- | ----------- | ------ | --- | --- |
|     | 444411QQTT--KK11XXHH0044EECCii | 00                | 0 1                     | 11JJ  |             | IINNDD |     |     |
|     |                                | KK                | 0 _ 0 _                 |       |             |        |     |     |
|     | 1 0 2 0                        | NN AA             | 0 O 0 O                 |       |             |        |     |     |
|     | _ 0 O _ 0 O                    | BB                | 9 I P / 0 I P / 1       |       |             |        |     |     |
|     | I C I C                        | 1 _ 2 _ 3 _       | 4 _ 1 _ N I N I         |       |             |        |     |     |
|     | AA33UU C V C V                 | C N C N C N       | C N C N B G B G         |       |             |        |     |     |
|     | 3 3 1 3 2 1                    | 0 1 1 4 2 1 5 2 1 | 0 3 1 1 3 1 9 2 1 8 2 1 |       |             |        |     |     |
55 FFuu
11 CC 11 .. 00
44 FFuu
11 CC 11 .. 00
V3.3+
| 5   |     |     |     |     |     |     |     | 5   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     | D   |     | C   |     | B   |     | A   |     |

|     | D   |     |     | C   |     |     | B   |     | A   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
vvveeeRRR AAA
555
fffooo
444
   AAAGGGPPPFFF   ---   tttiiiKKK   nnnoooiiitttaaauuulllaaavvvEEE   kkkccciiitttsssEEECCCiii
2 2 2 2 2 2 2
| 1   |     |     |     |     |     |     |     |     |     | ttteeeeeehhhSSS 1 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------------- |
L L T
|     |       | T T T _   |     |     |     |     |        |     |     | NNNVVVEEE---KKKCCCIIITTTSSS---KKK111XXXHHH000444EEECCCIII |
| --- | ----- | --------- | --- | --- | --- | --- | ------ | --- | --- | --------------------------------------------------------- |
|     |       | _ x T x R |     |     |     |     | 7722RR |     |     |                                                           |
|     | n n n | _ 2 _ 2 3 |     |     |     |     | KK0011 |     |     |                                                           |
D C n R S R T n S T S T 3 2 S 2 S
D D D C R R R
6622RR KK0011
SSSYYYSSSLLLEEEXXXAAA
|     |     |     |     |     |     |     |     |     |     | rrreeebbbmmmuuuNNN   tttnnneeemmmuuucccoooDDD 333111000222   ,,,666111   rrrpppAAA |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------------------------------------------------------------------------- |
5522RR KK0011
FF0044CCSSEE3311AA223300QQ5522NN
|     |           | 0 1 2 9     | 2 3 4 5 6 | 8 9 1 2 3 4   |     |                   |     |     |     |     |
| --- | --------- | ----------- | --------- | ------------- | --- | ----------------- | --- | --- | --- | --- |
|     | 1 2 3 4 7 | 8 9 1 1 1 1 | 2 2 2 2 2 | 2 2 3 3 3 3   |     | 6622CC FFuu11..00 |     |     |     |     |
|     | A B A B A | B A B A B A | B A B A   | B A B A B A B |     |                   | 2   | 7   |     |     |
0 0 P 0 0 P 1 0 P 1 0 P 2 0 P 2 0 P 3 0 P 3 0 P 4 0 P 4 0 P 7 0 P 8 0 P 9 0 P 9 0 P 0 1 P 0 1 P 1 1 P 1 1 P 2 1 P 2 1 P 3 1 P 3 1 P ODS DLOH :::eeetttaaaDDD
D / D / D / D / D / D / D / D / D / D / D / D / D / D / D / D / D / D / D / D / D / D / hhgguuoorrhhtt  ddeettuuoorr  eebb  yyaamm  ssnniipp  CCNN eeellltttiiiTTT eeezzziiiSSS BBB
|     | 2 0 _ 3 0 _ 4 0 _ 5 0 _ 6 0 _  | 7 0 _ 8 0 _ 9 0 _ 0 1 _ 1 1 _ 2 1 _ | 3 1 _ 4 1 _ 5 1 _ 6 1 _ | 7 1 _ 8 1 _ 9 1 _ 0 2 _ 1 2 _ 2 2 _ 3 2 _ |               |                    | CCV      | DNG               |     |     |
| --- | ------------------------------ | ----------------------------------- | ----------------------- | ----------------------------------------- | ------------- | ------------------ | -------- | ----------------- | --- | --- |
|     | 3 O 3 O 3 O 3 O 3 O            | 3 O 3 O 3 O 3 O 3 O 3 O             | 3 O 3 O 3 O 3 O         | 3 O 3 O 3 O 3 O 3 O 3 O 3 O               |               |                    | 8        | 4                 |     |     |
|     | I P I P I P I P I P            | I P I P I P I P I P I P             | I P I P I P I P         | I P I P I P I P I P I P I P               |               |                    |          | IDS KCS PW        |     |     |
|     |                                |                                     |                         |                                           |               |                    | 55UU     | SC                |     |     |
|     |                                |                                     |                         | A B                                       | 4422RR KK0011 |                    |          |                   |     |     |
|     |                                | 33                                  |                         | 8 0 P 7 0 P                               |               |                    | 5        | 6 3 1             |     |     |
|     | 444411QQTT--KK11XXHH0044EECCii |    KK                               |                         | D / D /                                   |               |                    |          |                   |     |     |
| 2   |                                | NN                                  |                         | 0 0 _ 1 0 _                               |               |                    |          |                   |     | 2   |
|     | 1 0 2 0                        | AA BB                               |                         | 3 O 3 O                                   |               |                    |          |                   |     |     |
|     | _ 3 _ 3                        |                                     |                         | I P / I P /                               |               |                    |          |                   |     |     |
|     | O I C O I C                    |                                     | 0 1 _                   | 1 1 _ 2 1 _ 3 1 _ 6 N 7 N                 | 0 7           | 8 6 7 6 1 7        |          |                   |     |     |
|     | DD33UU C V C V                 |                                     | C N                     | C N C N C N I B G I B G                   |               |                    |          |                   |     |     |
|     |                                |                                     |                         |                                           |               | K C I S O B _      | OSIM_ECi | ISOM_ECi B_SS_ECi |     |     |
|     | 6 0 3                          |                                     | 5 1 6 1                 | 7 1 8 1 1 2 0 2                           |               | S _ _ IP S _ I S S |          | KCS_ECi           |     |     |
IP S / 1 P S _ I P
S / 0 0 _ /2 0 S /
0 _ S S O _ S O 3 0 _
|     | 22 FFuu        |     |     |     | 444411QQTT--KK11XXHH0044EECCii | O I P IP S O |     |       |     |     |
| --- | -------------- | --- | --- | --- | ------------------------------ | ------------ | --- | ----- | --- | --- |
|     | 22 CC 11 .. 00 |     |     |     |                                | IP IP        | 2   | 2 2 2 |     |     |
KLC_EC
CC
|     | FFuu           |     |     |     |        | V II        |     |     |     |     |
| --- | -------------- | --- | --- | --- | ------ | ----------- | --- | --- | --- | --- |
|     | 11 22 CC 11 .. |     |     | i   | EE33UU | _I PS PP SS |     |     |     |     |
|     | V3.3+ 00       |     |     | 2   |        |             |     |     |     |     |
27
55 FFuu
22 CC 11 .. 00
V3.3+
| 3   |     |     |     |     |     |     |     |     |     | 3   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
0 1 1 1 2 1 3 1 4 1 5 1 6 1 7 1
_ 2 _ 2 _ 2 _ 2 _ 2 _ 2 _ 2 _ 2
O I P O I P O I P O I P O I P O I P O I P O I P
|     | 2 5 8 5           | 7 3 8 3 9 3 1 4 2 4 3 4 4 4 | 5 4 7 4 8 4 6 5 0 6 1 6 2 6 |                  |       |         |                                 |                         |     |     |
| --- | ----------------- | --------------------------- | --------------------------- | ---------------- | ----- | ------- | ------------------------------- | ----------------------- | --- | --- |
|     | 0 3               | 4 5 6 7 8 9 0               | 1 2 3 4 5 6                 | 7 hhgg uu        |       |         |                                 |                         |     |     |
|     | 0 _ 0 _           | 0 _ 0 _ 0 _ 0 _ 0 _ 0 _ 1 _ | 1 _ 1 _ 1 _ 1 _ 1 _ 1 _     | 1 _ oo rr        | V3.3+ |         |                                 |                         |     |     |
|     | 2 O 2 O           | 2 O 2 O 2 O 2 O 2 O 2 O 2 O | 2 O 2 O 2 O 2 O 2 O 2 O     | 2 O hh tt        |       |         |                                 |                         |     |     |
|     | I P I P           | I P I P I P I P I P I P I P | I P I P I P I P I P I P     | I P ddeettuuoorr |       |         |                                 |                         |     |     |
|     | 44 44             | 0 L                         | 1 L                         |                  |       | 71_2OIP | 61_2OIP 51_2OIP 41_2OIP 31_2OIP | 21_2OIP 11_2OIP 01_2OIP |     |     |
|     | 11 QQ             | 22 E S                      | E S 2 0                     | 1 0 ee bb        |       |         |                                 |                         |     |     |
|     | TT -- KK 1 0 2 0  |    KK B C                   | B C B _ 2 O                 | _ 2 O    yy aa   |       |         |                                 |                         |     |     |
|     | 11 XX _ 2 _ 2     | NN AA / 8                   | / 9 E _ T E I P             | I P mm           |       |         |                                 |                         |     |     |
|     | HH 00 O I C O I C | BB 9 1 _ 2                  | 1 _ 2 N O S E / 4 N         | / 5 N ss nn ii   |       |         |                                 |                         |     |     |
4 CC 33 44 EE C C _ C N O I O I D C R C I B G I B G pp    0011xx11  rreeddaaeehh  eellaammeeFF 4
|     | UU CC ii V V | P       | P                   | CC NN |     |       |         |        |     |     |
| --- | ------------ | ------- | ------------------- | ----- | --- | ----- | ------- | ------ | --- | --- |
|     | 6 4 7 5      | 5 5 3 6 | 4 6 5 6 6 6 0 5 9 4 |       |     | 1 2 3 | 4 5 6 7 | 8 9 01 |     |     |
IINNDD
|     |     |     |     | 33 IINN | 33JJ |     |     |     |     |     |
| --- | --- | --- | --- | ------- | ---- | --- | --- | --- | --- | --- |
22R R 00 D D
|     |     | 44 FFuu           | KK    |     |     |     |     |     |     |     |
| --- | --- | ----------------- | ----- | --- | --- | --- | --- | --- | --- | --- |
|     |     | 22 CC 11 .. 00    | 00 11 |     |     |     |     |     |     |     |
|     |     | FF uu             | 22 22 |     |     |     |     |     |     |     |
|     |     | 33 22 CC 11 .. 00 | RR    |     |     |     |     |     |     |     |
V3.3+
|     |       | 66 44 RR KK 00 |     |     |     |     |     |     |     |     |
| --- | ----- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- |
|     | V3.3+ | 11             |     |     |     |     |     |     |     |     |
E TS
N O E
D C R C
| 5   |     |     | _ E _ E |     |     |     |     |     |     | 5   |
| --- | --- | --- | ------- | --- | --- | --- | --- | --- | --- | --- |
C i C i
2 2
|     | D   |     |     | C   |     |     | B   |     | A   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

|     | D   |     | C   |     |     | B   |     |     |     | A   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
vvveeeRRR AAA
555
fffooo
|     |     |     |     |     |     |     | 0044   | 1 1       | dd e e |                                                                                                                 |                   |
| --- | --- | --- | --- | --- | --- | --- | ------ | --------- | ------ | --------------------------------------------------------------------------------------------------------------- | ----------------- |
|     |     |     |     |     |     |     | RR     | KK 11 D D | R R    | sssDDDEEELLL   ,,,rrreeewwwoooPPP   ---   tttiiiKKK   nnnoooiiitttaaauuulllaaavvvEEE   kkkccciiitttsssEEECCCiii |                   |
|     |     |     |     |     |     |     |        | 1         | 2      |                                                                                                                 | 555               |
| 1   |     |     |     |     |     |     |        |           |        |                                                                                                                 | ttteeeeeehhhSSS 1 |
|     |     |     |     |     |     |     | 1144RR | KK11 22DD | ddeeRR |                                                                                                                 |                   |
NNNVVVEEE---KKKCCCIIITTTSSS---KKK111XXXHHH000444EEECCCIII
|     |     |     |               |     |     |     |     | 1   | 2   |     |     |
| --- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |     |     | IINNDD 33PPTT |     |     |     |     |     |     |     |     |
1
ddeeRR
|     |              |     |               |     |      |     | 9933 | KK 33DD |     |                       |                                                                                    |
| --- | ------------ | --- | ------------- | --- | ---- | --- | ---- | ------- | --- | --------------------- | ---------------------------------------------------------------------------------- |
|     |              |     |               |     | sDEL |     | RR   | 11      |     | SSSYYYSSSLLLEEEXXXAAA |                                                                                    |
|     | FFuu1100..00 |     |               |     |      |     |      | 1       | 2   |                       | rrreeebbbmmmuuuNNN   tttnnneeemmmuuucccoooDDD 333111000222   ,,,222111   rrrpppAAA |
|     | 7733CC       |     | IINNDD 22PPTT |     |      |     |      |         |     |                       |                                                                                    |
1
44DD ddeeRR
8833RR KK11
|     | 6633CC FFuu11..00 |     | V2.1+ |     |     |     |     |     |     |     |     |
| --- | ----------------- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
|     | V3.3+             |     |       |     |     |     |     | 1   | 2   |     |     |
:::eeetttaaaDDD
|     | 5533CC   |     |               |     |     |     |        |      | nneeeerrGG | eeellltttiiiTTT | eeezzziiiSSS BBB |
| --- | -------- | --- | ------------- | --- | --- | --- | ------ | ---- | ---------- | --------------- | ---------------- |
|     | FFuu11   |     |               |     |     |     | 7733RR | 55DD |            |                 |                  |
|     |          |     | IINNDD 11PPTT |     |     |     |        | KK11 |            |                 |                  |
|     | FFuu0011 |     | 1             |     |     |     |        | 1    | 2          |                 |                  |
4433CC
V3.3+
| 2   |     |     |     |     |     | 0DEL 1DEL 2DEL | 3DEL 4DEL |     |     |     | 2   |
| --- | --- | --- | --- | --- | --- | -------------- | --------- | --- | --- | --- | --- |
|     |     |     |     |     |     | 3 3 3          | 3 3       |     |     |     |     |
V3.3+
00225500UUBBDDCC
1
66DD
|     |     |        |     |     |     |     | 2                              |             | V2.1+               |         |     |
| --- | --- | ------ | --- | --- | --- | --- | ------------------------------ | ----------- | ------------------- | ------- | --- |
|     |     |        |     |     |     |     | 9 8                            | 6           | 7                   | 1       |     |
|     |     |        |     |     |     |     | 0 1 0 1                        | 0 4 4 5 2 1 | 3 5 2 1 1 5 7 2 2 9 | 1 1     |     |
|     |     |        |     |     |     |     | T 5V                           | 8 7 6       | 5 4 1 2             | 3 4     |     |
|     |     | V3.3+  |     |     |     |     | S A 2                          | 1 _ 1 _ 1 _ | 1 _ 1 _ 0 _ 0 _     | 0 _ 0 _ |     |
|     |     |        |     |     |     |     | F _ _ P                        | C N C N C N | C N C N C C C C     | C C C C |     |
|     |     |        |     |     |     |     | P PV P V                       |             | V V                 | V V     |     |
| 3   |     | 8822RR |     |     |     |     | 444411QQTT--KK11XXHH0044EECCii |             |                     |         | 3   |
11..00
|     |              |               | V2.1+    |                   |     |     | RREEWWOOPP |                               |                         |            |     |
| --- | ------------ | ------------- | -------- | ----------------- | --- | --- | ---------- | ----------------------------- | ----------------------- | ---------- | --- |
|     |              |               |          |                   |     |     |            | 1 2 3 4 5                     | 6 7 8 9                 | C D        |     |
|     |              | V13.3+ 0033RR | 000011   |                   |     |     |            | 0 _ D 0 _ D 0 _ D 0 _ D 0 _ D | 0 _ D 0 _ D 0 _ D 0 _ D | C V N G    |     |
|     |              |               |          |                   |     |     | FF33UU     | N N N N N                     | N N N N                 | L L L L    |     |
|     |              |               |          |                   |     |     |            | G G G G G                     | G G G G                 | P P        |     |
|     |              | 8833CC        | FFuu0011 |                   |     |     |            | 5 3 4 9 9                     | 6 3 2 0 6               | 5          |     |
|     |              |               | 4433RR   | 11..00            |     |     |            | 1 1 5 6                       | 8 0 1 3 1 4 1 3         | 3          |     |
|     |              |               | KK001122 | 5533RR 000011     |     |     |            |                               |                         | FFuu11..00 |     |
|     |              |               | V22.1+   |                   |     |     |            |                               |                         | 5544CC     |     |
|     | FFuu1100..00 |               | 3333RR   | 1144CC FFuu77..44 |     |     |            |                               |                         |            |     |
3333CC
|     |     |     | KK775533 |     |     |     |     |     |     | 4444CC FFuu0011 |     |
| --- | --- | --- | -------- | --- | --- | --- | --- | --- | --- | --------------- | --- |
9922RR
|     | 2233CC FFuu11..00 |               |              |                         | FFBBPPRRTT##EEFFEE00330033TTLL |     |     |     |        |        |     |
| --- | ----------------- | ------------- | ------------ | ----------------------- | ------------------------------ | --- | --- | --- | ------ | ------ | --- |
|     |                   | 0044CC        | FFuu1100..00 | 2244CC FFuu1100..00     |                                |     |     |     |        |        |     |
|     |                   |               |              |                         |                                |     |     |     | 3344RR | 000011 |     |
|     | 1133CC FFuu11..00 |               |              | 01                      |                                |     |     |     |        |        |     |
|     |                   | 3 4           | 2 1 7        | 8 9                     |                                |     |     |     |        |        |     |
| 4   |                   | 1_1TUO 2_1TUO | 1PYB 1JDA    | 1_2TUO 2_2TUO 2PYB 2JDA |                                |     |     |     | V2.1+  |        | 4   |
|     | FFuu11..00        |               |              |                         | 4DNG 6                         |     |     |     |        |        |     |
|     | 0033CC            |               |              |                         | 3DNG                           |     |     |     |        |        |     |
5
|     |               |                 |             | DAPMREHT | 2DNG    |     |     |                   |       |     |     |
| --- | ------------- | --------------- | ----------- | -------- | ------- | --- | --- | ----------------- | ----- | --- | --- |
|     | FFuu11..00    |                 | 1DGRWP      | 2DGRWP   | 51      |     |     |                   |       |     |     |
|     | 9922CC        | 1_1NI 2 1 2_2NI | 1NDHS 2NDHS |          | 1DNG 61 |     |     |                   |       |     |     |
|     | V2.1+         | _ 1 N _ 2 N     |             |          |         |     |     | 3344CC FFuu11..00 | 2 2   |     |     |
|     |               | 66UU I I        |             |          |         |     |     |                   | MD PD |     |     |
|     | 8822CC FFuu11 | 81 7 4 31       | 02 11 91    | 21 12    |         |     |     |                   |       |     |     |
1 1
|     | 7722CC FFuu0011 |     |             |     |     |     |     |     |     |     |     |
| --- | --------------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |                 |     | 2233RR MM11 |     |     |     |     |     |     |     |     |
V5_SUBV
|     |     |     | 1133RR MM11 |     |     |     |     |     | 1 2 3 4   |                      |     |
| --- | --- | --- | ----------- | --- | --- | --- | --- | --- | --------- | -------------------- | --- |
|     |     |     |             |     |     |     |     |     | C - D + D | D 0099  MMAA  BBSSUU |     |
C V N G
44JJ
|     |     |     | 9933CC FFuu0011 |     |     |     |     |     |     |     |     |
| --- | --- | --- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- |
V5_SUBV
| 5   |     |     |     |     |     |     |     |     |     |     | 5   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     | D   |     | C   |     |     | B   |     |     |     | A   |     |
