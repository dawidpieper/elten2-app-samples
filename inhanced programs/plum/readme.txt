this is a program that makes melody from "plum" sounds, formarly known as feed updating ding sound that plays when someone writes to an elten feed.
here's how it works
open plum program from programs menu.
there you will find 3 buttons:
play button: plays the loaded melody or default one
load button: asks you to choose a file of melody to load. the file extention is .rbna, and it is a ruby 2d array. more on creating melodies in next chapter.
open melodies folder button: opens a folder with melodies.
close button: exits.

melody creation:
it is recommended to put your melodies to appdata\roaming\elten\apps\plum\melodies
the melody file is an 2 dimentional array program code, so you can use expressions and functions of ruby that returns numbers.
the sintax is as folows:
[ #a left bracket in a single line
[note,length],
[note,length],
[note,length],
[note,length]
] # a right bracket
everything that is after # hashtag, hash symbol, and before the line ending is a comment. for example
[0,100] #this is a note 0 with length 100. this is a comment.
the left bracket at the start, and a right bracket at the end of a melody is necessary. they are telling to the interpreter that the array is starting or ending.
the sintax of note is as follows: a left bracket, note number, comma, a length number, right bracket, comma. and you can put a new line if you want.
note number is a number between -12 and 12.
0 is the original pitch of plum sound, the note:a, in first octave.
and 1 is A#, 2 is b, 3 is c, 4 is c# and so on. the note number changes every semytone, it meens if you write note 0, then note 1, then 2, 3, 4, 5, and till 12, it will play the chromatic scale.
for example if you want to write a major cord, you will write
[
[0,200],
[4,200],
[7,500]
]

lets take a look on this
in the first line there is a left bracket.
in the second line: the note is 0, and the note length is 200 milliseconds. it is written like this:
[0,200],
then note 4, which meens c# note. 
then note 7, which meens the note e, but with length 500 milliseconds.
then the song ends with array ending symbol: right bracket!
after the last note, don't write comma. 
now we will write chromatic scale from a, to upper a, in second octave

[
[0,100],
[1,100],
[2,100],
[3,100],
[4,100],
[5,100],
[6,100],
[7,100],
[8,100],
[9,100],
[10,100],
[11,100],
[12,100]
]
the negative numbers in notes are also allowed. it meens: -1 is a flat, -2 is g, -3 is f sharp, -4 is f, -5 is e, -6 is e flat and so on till -12. -12 is a.

if you want, you can use constants and expressions:
[0,1000/4]
this note is the note 0, note a, with length 1000/4 milliseconds, it meens quarter second, 250 milliseconds.
you also can use rand function in ruby programming language. rand(maxnumber) returns random number from 0 to maxnumber-1. so if you write a note:
[rand(11),rand(101)+100]
it will play a random note from a, to upper a, and with random length from 100 milliseconds to 200.
you can also use so called array multiplyers to make a repeated sequence of notes. for example play a notes a b c d e, then play 5 times note a c e.
[
[0,100],
[2,100],
[4,100],
[5,100],
[7,500]
] + [
[0,250],
[4,250],
[7,500]
]*5

here are 2 arrays:
1 array with notes a, b, c, d, e, and the second array is added with + plus sign, and it has notes a, c, e. and the array multiplied 5 times, so notes a b c d e will play 1 time, and notes a c e will play 5 times.

you can also use the program with console:
plummelody
plays the loaded or default melody
plumload
asks you which file to load.
or if you write: plumload("c:/path/to/the/melody.rbna")
it will load the song in this path.
note that you need to use slashes in path to the file, or you can use double backslash. eather c:/users/path.rbna, or c:\\users\\path. you cannot use single backslash. it is the ruby language feature.
