require_relative './drawing_app'
class Interface
    def initialize
        @drawing_app = DrawingApp.new
        @help_text =    {   "g" => "These are your current options\n HINTS: whenever it says M,N,X,Y,X1,Y2,X2, or Y2 replace them with integers.\nReplace C with any letter.):",
                            "d" => "----------------------------------------------------",
                            "i" => "Enter I M N to create a new M x N image with all pixels colored white (O).\n",        
                            "c" => "Enter C to clear the table, setting all pixels to white (O).\n",
                            "l" => "Enter L X Y C to color the pixel (X,Y) with color C.\n",
                            "v" => "Enter V X Y1 Y2 C to draw a vertical segment of color C in column X between rows Y1 and Y2 (inclusive).\n",
                            "h" => "Enter H X1 X2 Y C to draw a horizontal segment of color C in row Y between columns X1 and X2 (inclusive).\n",
                            "r" => "Enter R X1 Y2 X2 Y2 C to draw a rectangle of color c with one corner at X1,Y1, and the opposite corner at X2,Y2\n",
                            "f" => "Enter F X Y C to fill a region of one color with a new color by selecting a pixel in the region and a new color.\n",
                            "s" => "Enter S to to show the contents of the current image\n",
                            "m" => "Enter M at any time to return to this menu",
                            "x" => "Type X to terminate the session\n" 
                        }

        @example_text = {   "i" => "Example: entering I 9 9 makes a 9x9 grid.\n",
                            "l" => "Example: L 5 4 A colors a pixel at coordinates 5,4 with the 'color' A\n",
                            "v" => "Example: V 3 2 8 B draws a vertical line of 'color' B on column three, from row 2 to row 8\n",
                            "h" => "Example: H 2 8 3 B draws a horizontal line of 'color' B from column 2 to column 8 on row 3\n",
                            "f" => "Example: F 2 3 J will change color of the pixel at 2,3 to the 'color' J and any connected pixels of the same color. It is a fill tool.",
                            "r" => "Example: R 1 1 3 3 F will create a rectangle with color F and corners at 1,1 and 3,3"
                        }

        @error_text =   {   "i m" => "**ERROR: M must be an integer greater than 0 **",
                            "i n" => "**ERROR: N must be an integer between 1 and 250 **",
                            "c"   => "**ERROR: C can only be a single letter from A-Z. All letters will be capitalized automatically **"
                        }

        @prompt_text = {    1 => "What would you like to do next ( press M or the enter key for help)?",
                            2 => "Here's your new graph!",
                            3 => "Graph cleared."
                        }
        help
    end

    def help
        if @drawing_app.graph
            @help_text.each {|k,v| puts v}
        else
            puts @help_text["i"]
            puts @example_text["i"]
            puts @help_text["x"]
        end
        get_input
    end


    def get_input     
        input = gets.strip
        puts "\n"
        puts @help_text["d"]
        process_input(input)
    end

    def process_input(input)
        input = input.split(' ')
        if @drawing_app.graph
            options = ['I', 'C', 'L', 'V', 'H', 'F', 'R', 'S', 'M', 'X']
        else
            options = ['I', 'X']
        end

        if input[0].kind_of? String
            if options.include? input[0].upcase
                take_action(input)
            else
                help
            end
        else
            help
        end
    end

    def take_action(input)
        input[0] = input[0].upcase
        case input[0]
        when "I"
            if validate_m(input[1])
                if validate_n(input[2])
                    @drawing_app.create_new_image(input[1].to_i, input[2].to_i)
                    @drawing_app.show
                    puts @prompt_text[2]
                    help
                else
                    puts @error_text["i n"]
                    get_input
                end
            else
                puts @error_text["i m"]
                get_input
            end
        when "C"
            @drawing_app.clear_table
            @drawing_app.show
            puts @prompt_text[3]
            puts @prompt_text[1]
            get_input
        when "L"
            if validate_x(input[1])
                if validate_y(input[2])          
                    if validate_c(input[3])
                        @drawing_app.color_pixel(input[1].to_i, input[2].to_i, input[3])
                        @drawing_app.show
                        puts @prompt_text[1]
                        get_input
                    else
                        puts @error_text["c"]
                        puts @example_text["l"]
                        get_input
                    end
                else
                    y_error
                    get_input
                end
            else
                x_error
                get_input
            end
        when "V"
            if validate_x(input[1])
                if validate_y(input[2])
                    if validate_y(input[3])
                        if validate_c(input[4])
                            @drawing_app.draw_vertical(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
                            @drawing_app.show
                            puts @prompt_text[1]
                            get_input
                        else
                            puts @error_text["c"]
                            puts @example_text["v"]
                            get_input
                        end
                    else
                    y_error
                    get_input
                    end
                else
                    y_error
                    get_input
                end
            else
                x_error
                get_input
            end

        when "H"
            if validate_x(input[1])
                if validate_x(input[2])
                    if validate_y(input[3])
                        if validate_c(input[4])
                            @drawing_app.draw_horizontal(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
                            @drawing_app.show
                            puts @prompt_text[1]
                            get_input
                        else
                            puts @error_text["c"]
                            puts @example_text["h"]
                            get_input
                        end
                    else
                        y_error
                        get_input
                    end
                else
                    x_error
                    get_input
                end
            else
                x_error
                get_input
            end
        when "F"
            if validate_x(input[1])
                if validate_y(input[2])          
                    if validate_c(input[3])
                        @drawing_app.fill_region(input[1].to_i, input[2].to_i, input[3])
                        @drawing_app.show
                        puts @prompt_text[1]
                        get_input
                    else
                        puts @error_text["c"]
                        puts @example_text["f"]
                        get_input
                    end
                else
                    y_error
                    get_input
                end
            else
                x_error
                get_input
            end
        when "S"
                @drawing_app.show
                puts @prompt_text[1]
                get_input
        when "R"
            if validate_x(input[1])
                if validate_y(input[2])          
                    if validate_x(input[3])
                        if validate_y(input[4])
                            if validate_c(input[5])
                                @drawing_app.create_rectangle(input[1].to_i, input[2].to_i, input[3].to_i, input[4].to_i, input[5])
                                @drawing_app.show
                                puts @prompt_text[1]
                                get_input
                            else
                                puts @error_text["c"]
                                puts @example_text["r"]
                                get_input
                            end
                        else
                            y_error
                            get_input
                        end
                    else
                        x_error
                        get_input
                    end
                else
                    y_error
                    get_input
                end
            else
                x_error
                get_input
            end
        when "M"
            help
        when "X"
            puts "Thanks for using this graphing program!"
            exit
        end
    end

    private

    def validate_m(m)
        m.to_i > 0
    end

    def validate_n(n)
        n.to_i > 0
    end

    def validate_x(x)
        x = x.to_i
        validate_m(x) and x <= @drawing_app.columns
    end

    def validate_y(y)
        y = y.to_i
        validate_n(y) and y <= @drawing_app.rows    
    end

    def validate_c(c)
        (("A".."Z").include? c) or (("a".."z").include? c)
    end

    def x_error
        puts "**ERROR: X must be an integer between 0 and #{@drawing_app.columns.inspect} **\n Please try again"
    end

    def y_error
        puts "**ERROR Y must be an integer between 0 and #{@drawing_app.rows.inspect} **\n Please try again"
    end
end

@interface = Interface.new