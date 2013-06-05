class DrawingApp
    attr_reader :columns
    attr_reader :rows
    attr_reader :graph

    def create_new_image(columns, rows)
        @graph = Array.new
        @columns = columns
        @rows = rows
        rows.times {@graph.push << []}
        @graph.each do |r|
           columns.times { r << "O"}
        end
    end

    ##################
    # C: CLEAR TABLE #
    ##################

    def clear_table
        @graph.each do |r|
            r.collect! { |p| p = "O"}
        end
    end

    ####################
    # L: COLOR A PIXEL #
    ####################

    def color_pixel(x,y,c)
        x = x - 1
        y = y - 1
        c = c.upcase
        change_color(x,y,c)
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
        c = c.upcase
        if y1 <= y2
            rows = @graph[y1..y2]
        else
            rows = @graph[y2..y1]
        end
        rows.each do |p|
            p[x] = c
        end
    end

    ###########################
    # DRAW HORIZONTAL SEGMENT #
    ###########################

    def draw_horizontal(x1,x2,y,c)
        x1 = x1 - 1
        x2 = x2 - 1
        y  = y  - 1
        c = c.upcase
        row = @graph[y]
        if x1 <= x2
            line_length = x2 - x1 + 1
            row[x1..x2] = [c] * line_length
        else
            line_length = x1 - x2 + 1
            row[x2..x1] = [c] * line_length
        end
    end

    #########################
    #       FILL TOOL       #
    #########################

    def fill_region(x,y,c)
        x = x - 1
        y = y - 1
        c = c.upcase
        oc = @graph[y][x]
        @graph[y][x] = c
        fill_algorithm(x,y,c,oc)
    end

    def fill_algorithm(x,y,c,oc)
        (x-1..x+1).each do |newX|
            (y-1..y+1).each do |newY|
                if @graph[newY]
                    if @graph[newY][newX] == oc
                        change_color(newX,newY,c)
                        fill_algorithm(newX, newY, c, oc)
                    end
                end
            end
        end
    end

    #########################
    #     PICTURE FRAME     #
    #########################

    def picture_frame(x1,y1,x2,y2,c)
        draw_horizontal(x1,x2,y1,c)
        draw_horizontal(x1,x2,y2,c)
        draw_vertical(x1,y1,y2,c)
        draw_vertical(x2,y1,y2,c)
    end

    #########################
    #    FILLED RECTANGLE   #
    #########################
    def rectangle(x1,y1,x2,y2,c)x2 = x2 - 1
        c = c.upcase
        if x1 < x2
            low_x = x1 - 1
            high_x = x2 - 1
        else 
            low_x = x2 -1
            high_x = x1 - 1            
        end
        if y1 < y2
            low_y = y1 - 1
            high_y = y2 - 1
        else 
            high_y = y1 - 1
            low_y = y1 - 1
        end
        (low_x..high_x).each do |x|
            (low_y..high_y).collect{|y|@graph[y][x] = c}
        end            
    end

    #########################
    #       DIAGONAL       #
    #########################
    def diagonal(y1,y2,c)
        y1 = y1 - 1
        y2 = y2 - 1
        c = c.upcase
        if y1 < y2
            (y1..y2).collect{|i|@graph[i][i] = c}
        else
            (y2..y1).collect{|i|@graph[i][i] = c}
        end
    end


    #########################
    #         SHOW          #
    #########################

    def show
        @graph.each do |r|
            puts r.map { |p| p }.join("")
        end
        puts "\n"
    end
end