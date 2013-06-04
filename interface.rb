require_relative './drawing_app'
class Interface
    def initialize
        @drawing_app = DrawingApp.new
        @help_text = {  "g" => "These are your current options\n (HINT: whenever it says M,N,X,Y,X1, or X2, replace them with integers. Replace C with any letter.):",
                        "d" => "----------------------------------------------------",
                        "i" => "Enter I M N to create a new M x N image with all pixels colored white (O).\n",        
                        "c" => "Enter C to clear the table, setting all pixels to white (O).\n",
                        "l" => "Enter L X Y C to color the pixel (X,Y) with color C.\n",
                        "v" => "Enter V X Y1 Y2 C to draw a vertical segment of color C in column X between rows Y1 and Y2 (inclusive).\n",
                        "h" => "Enter X1 X2 Y C to draw a horizontal segment of color C in row Y between columns X1 and X2 (inclusive).\n",
                        "f" => "Enter F X Y C to fill a region of one color with a new color by selecting a pixel in the region and a new color.\n",
                        "s" => "Enter S to to show the contents of the current image\n",
                        "m" => "Enter M at any time to return to this menu",
                        "x" => "Type X to terminate the session\n" }

        @example_text = {   "i" => "Example: entering I 9 9 makes a 9x9 grid.\n",
                            "l" => "Example: L 5 4 A colors a pixel at coordinates 5,4 with the 'color' A\n",
                            "v" => "Example: V 3 2 8 B draws a vertical line of 'color' B on column three, from row 2 to row 8\n",
                            "h" => "Example: H 2 8 3 B draws a horizontal line of 'color' B from column 2 to column 8 on row 3\n",
                            "f" => "Example: F 2 3 J will change color of the pixel at 2,3 to the 'color' J, 
                                and any connected pixels of the same color. It is a fill tool."}

        @error_text = { "i m" => "M must be an integer greater than 0",
                        "i n" => "N must be an integer between 1 and 250",
                        "x" => "X must be an integer greater than 0",
                        "y" => "Y must be an integer greater than 0"}
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
        process_input(input)
    end

    def process_input(input)
        input_array = input.split(' ')
        if @drawing_app.graph
            options = ['I', 'C', 'L', 'V', 'H', 'F', 'S', 'M', 'X']
        else
            options = ['I', 'X']
        end

        if input_array[0].kind_of? String
            if options.include? input_array[0].upcase   
                take_action(input_array)
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
            if validate_x(input[1])
                if validate_y(input[2])
                    @drawing_app.create_new_image(input[1].to_i, input[2].to_i)
                    help
                else
                    puts @error_text["i n"]
                    puts @example_text["i"]
                    get_input
                end
            elsif !validate_x(input[1]) && !validate_y(input[2])
                puts @error_text["i n"]
                puts @error_text["i m"]
                puts @example_text["i"]
                get_input
            else
                puts @error_text["i m"]
                puts @example_text["i"]
                get_input
            end
        when "C"
            @drawing_app.clear_table
            puts "Graph cleared. What's next?"
            help
        when "L"            
            if validate_x(input[1])
                if validate_y(input[2])
                    @drawing_app.color_pixel(input[1].to_i, input[2].to_i, input[3])
                else
                    puts @example_text["l"]
                    get_input
                end
            else
                puts @example_text["l"]
                get_input    
            end        
        when "V"
                @drawing_app.draw_vertical(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
                help
        when "H"
                @drawing_app.draw_horizontal(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
                help
        when "F"
                @drawing_app.fill_region(input[1].to_i, input[2].to_i, input[3])
                help
        when "S"
                @drawing_app.show
                help
        when "M"
            help
        when "X"
            puts "Thanks for using this graphing program!"
            exit
        end
    end

    private

    def validate_x(x)
        x.to_i > 0
    end

    def validate_y(y)
        y.to_i > 0
    end
end

@interface = Interface.new