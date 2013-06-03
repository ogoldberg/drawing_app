class DrawingApp
    attr_reader :columns
    attr_reader :rows
    attr_reader :graph

    ###########################
    # I: INITIALIZE NEW GRAPH #
    ###########################

    def initialize
        input = ["I"]
        set_columns(input)
    end

    def set_columns(input)
        print "Let's make a graph! Please enter the number of columns:"
        input << gets.strip.to_i
        validate_columns(input)
    end 

    def set_rows(input)
        puts "Please enter the number of rows (between 1 and 250):"
        input << gets.strip.to_i
        validate_rows(input)
    end

    def create_new_image(columns, rows)
        @graph = Array.new
        rows.times {@graph.push << []}
        @graph.each do |r|
           columns.times { r << "O"}
        end
        show
        puts "Nice! Now that we have a graph, we can play around with it. What would you like to do next?"
        help
    end

    ##################
    # C: CLEAR TABLE #
    ##################

    def clear_table
        @graph.each do |r|
            r.collect! { |p| p = "O"}
        end
        show
        puts "Graph cleared"
        help
    end

    ####################
    # L: COLOR A PIXEL #
    ####################

    def set_pixel_column
        puts "Which column is the pixel in? 1-#{@graph[0].count.to_s}"
        x = gets.strip.to_i
        validate_pixel_column(x)
    end

    def set_pixel_row(x)
        puts "Which row is the pixel in? 1-#{@graph.count.to_s}"
        y = gets.strip.to_i
        validate_pixel_row(x,y)
    end

    def set_pixel_color(x,y)
        puts "What color should the pixel be? This can be any letter. Your letter will be automatically capitalized:"
        c = gets.strip.upcase
        validate_pixel_color(x,y,c)
    end

    def convert_input(x,y,c)
        x = x - 1
        y = y - 1
        change_color(x,y,c)
        show
        help
    end

    def change_color(x,y,c)
        @graph[y][x] = c
    end


    #########################
    # DRAW VERTICAL SEGMENT #
    #########################

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

    #########################
    # DRAW HORIZONTAL SEGMENT #
    #########################

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

    #########################
    #       FILL TOOL       #
    #########################

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

    #########################
    #         SHOW          #
    #########################

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
        case input[0]
        when "I"
            validate_columns(input)
            create_new_image(input[1], input[2])
        when "C"
            clear_table
        when "L"
            set_pixel_column
        when "V"
            draw_vertical(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
        when "H"
            draw_horizontal(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
        when "F"
            fill_region(input[1].to_i, input[2].to_i, input[3])
        when "S"
            show
        when "X"
            terminate_session
        else
            help
        end
    end

    def help
        puts "These are your options:
        I M N. Create a new M x N image with all pixels colored white (O)
        C. Clear the current image, setting all pixels to white (O).
        L. Color a single pixel
        V. Draw a vertical segment of color
        H. Draw a horizontal segment of color
        F. Fill a region
        S. Show the contents of the current image
        X. Terminate the session"
        input = gets.strip.split(/ /)
        input[0] = input[0].upcase
        validate_command(input)
    end
    ###############
    # VALIDATIONS #
    ###############

    def validate_command(input)
        if input[0].length == 1
            take_action(input)
        else
            puts "I didn't understand your entry. Please try again."
            help
        end
    end

    # create graph
    def validate_columns(input)
        input[1] = input[1].to_i
        if input[1] > 0
            validate_rows(input)
        else
            puts "To set the number of columns, please enter an integer greater than zero"
            input[1] = gets.strip.to_i
            validate_columns(input)
        end
    end

    def validate_rows(input)
        input[2] = input[2].to_i
        if (1..250).include?(input[2])
            puts input.inspect
            create_new_image(input[1], input[2])
        else
            puts "To set the number of rows, please enter an integer between 1 and 250"
            input[2] = gets.strip.to_i
            validate_rows(input)
        end
    end

    # color pixel
    def validate_pixel_column(x)
        if (1..@graph.count).include?(x)
            set_pixel_row(x)
        else
            puts "You have entered an invalid column. Please try again."
            set_pixel_column
        end
    end

    def validate_pixel_row(x,y)
        if (1..@graph[0].count).include?(y)
            set_pixel_color(x,y,)
        else
            puts "You have entered an invalid row. Please try again."
            set_pixel_row(x)
        end
    end

    def validate_pixel_color(x,y,c)
        if ("A".."Z").include?(c)
            convert_input(x,y,c)
        else
            puts "You have entered an invalid color. Please try again."
            set_pixel_color(x,y)
        end
    end
end

DrawingApp.new