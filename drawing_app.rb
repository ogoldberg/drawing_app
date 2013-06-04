class DrawingApp
    attr_reader :columns
    attr_reader :rows
    attr_reader :graph

    def create_new_image(columns, rows)
        @graph = Array.new
        rows.times {@graph.push << []}
        @graph.each do |r|
           columns.times { r << "O"}
        end
        show
    end

    ##################
    # C: CLEAR TABLE #
    ##################

    def clear_table
        @graph.each do |r|
            r.collect! { |p| p = "O"}
        end
        show
    end

    ####################
    # L: COLOR A PIXEL #
    ####################

    def color_pixel(x,y,c)
        x = x - 1
        y = y - 1
        change_color(x,y,c)
        show
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

    ###########################
    # DRAW HORIZONTAL SEGMENT #
    ###########################

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
end