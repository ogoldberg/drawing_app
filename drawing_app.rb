class DrawingApp
    attr_reader :columns
    attr_reader :rows
    attr_reader :graph
    

    def initialize
        @help_text = {"i" => "I M N. Create a new M x N image with all pixels colored white (O).\n",
        
        
        "c" => "C. Clears the table, setting all pixels to white (O).\n",
        "l" => "L X Y C. Colors the pixel (X,Y) with color C.\n    Example: L 5 4 X\n",
        "v" => "V X Y1 Y2 C. Draw a vertical segment of color C in column X between rows Y1 and Y2 (inclusive).\n     Example: V 3 2 8",
        "h" => "H X1 X2 Y C. Draw a horizontal segment of color C in row Y between columns X1 and X2 (inclusive).\n",
        "f" => "F X Y C. Fill the region R with the color C. R is defined as: Pixel (X,Y) belongs to R. 
        Any other pixel which is the same color as (X,Y) and shares a common side with any pixel in R also belongsto this region.\n",
        "s" => "S. Show the contents of the current image\n",
        "x" => "X. Terminate the session\n"}

        @example_text = {"i example" =>  "Example: entering I 9 9 makes a 9x9 grid.\n"}

        @error_text = {"i m error" => "M must be an integer greater than 0",
                       "i n error" => "N must be an integer between 1 and 250"}
        help
    end

    def help
        @help = @help_text.each {|k,v| puts v}
        interface
    end


    def interface        
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

    def create_new_image(columns, rows)
        @columns = columns
        @rows = rows
        @graph = Array.new
        rows.times {@graph.push << []}
        @graph.each do |r|
           columns.times { r << "O"}
        end
        show
        help
    end

    def clear_table
        @graph.each do |r|
            r.collect! { |p| p = "O"}
        end
        show
    end

    def color_pixel(x,y,c)
        x = x - 1
        y = y - 1
        @graph[y][x] = c
    end

    def draw_vertical(x,y1,y2,c)
        x  = x  - 1
        y1 = y1 - 1
        y2 = y2 - 1
        if y1 <= y2
            rows = @graph[y1..y2]
        else
            rows = @graph[y2..y1]
        end
        rows.each do |p|
            p[x] = c
        end
        show
    end

    def draw_horizontal(x1,x2,y,c)
        x1 = x1 - 1
        x2 = x2 - 1
        y  = y  - 1
        row = @graph[y]
        if x1 <= x2
            line_length = x2 - x1 + 1
            row[x1..x2] = ["G"] * line_length
        else
            line_length = x1 - x2 + 1
            row[x2..x1] = ["G"] * line_length
        end
        show
    end

    def fill_region(x,y,c)
        oc = @graph[y][x]
        @graph[y][x] = c
        fill_algorithm(x,y,c,oc)
        show
    end

    def fill_algorithm(x,y,c,oc)
        #fill to the left
        if @graph[y][x-1] == oc
            x = x-1
            change_color(x,y,c)
            fill_algorithm(x,y,c,oc)
        end
        #fill top left
        if @graph[y-1][x-1] == oc
            x = x-1
            y = y-1
            change_color(x,y,c)
            fill_algorithm(x,y,c,oc)
        end
        #fill upwards
        if @graph[y-1][x] == oc
            y = y-1
            change_color(x,y,c)
            fill_algorithm(x,y,c,oc)
        end
        #fill top right
        if @graph[y-1][x+1] == oc
            x = x+1
            y = y-1
            change_color(x,y,c)
            fill_algorithm(x,y,c,oc)
        end
        #fill to the right
        if @graph[y][x+1] == oc
            x = x+1
            change_color(x,y,c)
            fill_algorithm(x,y,c,oc)
        end
        #fill bottom right
        if @graph[y+1][x+1] == oc
            x = x+1
            y = y+1
            change_color(x,y,c)
            fill_algorithm(x,y,c,oc)
        end
        #fill downwards
        if @graph[y+1][x] == oc
            y = y + 1
            change_color(x,y,c)
            fill_algorithm(x,y,c,oc)
        end
        #fill bottom left
        if @graph[y+1][x-1] == oc
            x = x-1
            y = y+1
            change_color(x,y,c)
            fill_algorithm(x,y,c,oc)
        end
    end

    def change_color(x,y,c)
        @graph[y][x] = c
    end

    def show
        @graph.each do |r|
            puts r.map { |p| p }.join(" ")
        end
        puts "\n"
    end

    def terminate_session

    end

private

    def take_action(input)
        input[0] = input[0].upcase
        case input[0]
        when "I"
            if input[1].to_i > 0
                if (1..250).include?(input[2].to_i)
                    create_new_image(input[1].to_i, input[2].to_i)
                else
                    puts @error_text["i n error"]
                    puts @example_text["i example"]
                    interface
                end
            elsif input[1].to_i <= 0 && !(1..250).include?(input[2].to_i)
                puts @error_text["i n error"]
                puts @error_text["i m error"]
                puts @example_text["i example"]
                interface
            else
                puts @error_text["i m error"]
                puts @example_text["i example"]
                interface
            end
        when "C"
            clear_table
        when "L"
            color_pixel(input[1].to_i, input[2].to_i, input[3])
        when "V"
           draw_vertical(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
        when "H"
            draw_horizontal(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
        when "F"
            fill_region(input[1].to_i, input[2].to_i, input[3])
        when "S"
            show
        when "X"
            puts "Thanks for using this graphing program!"
            exit
        end
    end
end

d = DrawingApp.new
d.interface
