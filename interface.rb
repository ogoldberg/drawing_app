require_relative './drawing_app'
class Interface
    def initialize
        @drawing_app = DrawingApp.new
        @help_text = {  "i" => "I M N. Create a new M x N image with all pixels colored white (O).\n",        
                        "c" => "C. Clears the table, setting all pixels to white (O).\n",
                        "l" => "L X Y C. Colors the pixel (X,Y) with color C.\n",
                        "v" => "V X Y1 Y2 C. Draw a vertical segment of color C in column X between rows Y1 and Y2 (inclusive).\n",
                        "h" => "H X1 X2 Y C. Draw a horizontal segment of color C in row Y between columns X1 and X2 (inclusive).\n",
                        "f" => "F X Y C. Fill the region R with the color C. R is defined as: Pixel (X,Y) belongs to R. 
                                Any other pixel which is the same color as (X,Y) and shares a common side with any pixel in R also belongs to this region.\n",
                        "s" => "S. Show the contents of the current image\n",
                        "x" => "X. Terminate the session\n" }

        @example_text = {   "i example" => "Example: entering I 9 9 makes a 9x9 grid.\n",
                            "c example" => "Example: L 5 4 A colors a pixel at coordinates 5,4 with the 'color' A\n",
                            "v example" => "Example: V 3 2 8 B draws a vertical line of 'color' B on column three, from row 2 to row 8\n",
                            "h example" => "Example: H 2 8 3 B draws a horizontal line of 'color' B from column 2 to column 8 on row 3\n",
                            "f example" => "Example: F 2 3 J will change color of the pixel at 2,3 to to the 'color' J, 
                                and any connected pixels of the same color. It is a fill tool."}

        @error_text = { "i m error" => "M must be an integer greater than 0",
                        "i n error" => "N must be an integer between 1 and 250"}
        help
    end

    def help
        @help = @help_text.each {|k,v| puts v}
        get_input
    end


    def get_input        
        input = gets.strip
        process_input(input)
    end

    def process_input(input)
        input_array = input.split(' ')
        puts input_array[0].upcase.inspect
        if ['I', 'C', 'L', 'V', 'H', 'F', 'S', 'X'].include? input_array[0].upcase        
            take_action(input_array)
        elsif
            help
        end
    end

    def take_action(input)
        input[0] = input[0].upcase
        case input[0]
        when "I"
            if input[1].to_i > 0
                if (1..250).include?(input[2].to_i)
                    @drawing_app.create_new_image(input[1].to_i, input[2].to_i)
                    help
                else
                    puts @error_text["i n error"]
                    puts @example_text["i example"]
                    get_input
                end
            elsif input[1].to_i <= 0 && !(1..250).include?(input[2].to_i)
                puts @error_text["i n error"]
                puts @error_text["i m error"]
                puts @example_text["i example"]
                get_input
            else
                puts @error_text["i m error"]
                puts @example_text["i example"]
                get_input
            end
        when "C"
            if @graph
                @drawing_app.clear_table
            else
                puts "Please create a graph first"
                puts @example_text["i example"]
                get_input
            end
        when "L"
            if @graph
                @drawing_app.set_pixel_column
            else
                puts "Please create a graph first"
                puts @example_text["i example"]
                get_input
            end
        when "V"
            if @graph
                @drawing_app.draw_vertical(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
            else
                puts "Please create a graph first"
                puts @example_text["i example"]
                get_input
            end
        when "H"
            if @graph
                @drawing_app.draw_horizontal(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
            else
                puts "Please create a graph first"
                puts @example_text["i example"]
                get_input
            end
        when "F"
            if @graph
                @drawing_app.fill_region(input[1].to_i, input[2].to_i, input[3])
            else
                puts "Please create a graph first"
                puts @example_text["i example"]
                get_input
            end
        when "S"
            if @graph
                @drawing_app.show
            else
                puts "Please create a graph first"
                puts @example_text["i example"]
                get_input
            end
        when "X"
            puts "Thanks for using this graphing program!"
            exit
        end
    end
end

@interface = Interface.new