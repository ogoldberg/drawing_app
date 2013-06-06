drawing_app
===========

This is an ASCII art app written with Ruby 1.9.3.

run `ruby interface.rb` to make it go.

run `rake` to run the tests.

USING THE APP:
-------------
These are the command options:

    *Enter I M N to create a new M x N image with all pixels colored white (O).
    *Enter C to clear the table, setting all pixels to white (O).
    *Enter L X Y C to color the pixel (X,Y) with color C.
    *Enter V X Y1 Y2 C to draw a vertical segment of color C in column X between rows Y1 and Y2 (inclusive).
    *Enter H X1 X2 Y C to draw a horizontal segment of color C in row Y between columns X1 and X2 (inclusive).
    *Enter P X1 Y2 X2 Y2 C to draw a picture frame of color c with one corner at X1,Y1, and the opposite corner at X2,Y2
    *Enter R X1 Y2 X2 Y2 C to draw a filled rectangle of color c with one corner at X1,Y1, and the opposite corner at X2,Y2
    *Enter F X Y C to fill a region of one color with a new color by selecting a pixel in the region and a new color.
    *Enter S to to show the contents of the current image
    *Press the enter key at any time to see the menu
    *Type X to terminate the session

Whenever it says M,N,X,Y,X1,Y2,X2, or Y2 you should replace them with integers.

Replace C with any of these letters:

    B = Blue
    K = Black
    C = Cyan
    G = Green
    M = Magenta
    O = White
    R = Red
    Y = Yellow

