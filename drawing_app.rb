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
        begin
            @graph.each do |r|
                r.collect! { |p| p = "O"}
            end
        rescue Exception
            STDERR.puts "Invalid input for clear_table"
        end
    end

    ####################
    # L: COLOR A PIXEL #
    ####################

    def color_pixel(x,y,c)
        begin
            @graph[y][x] = c
        rescue Exception
            STDERR.puts "Invalid input for color_pixel"
        end
    end


    #########################
    # DRAW VERTICAL SEGMENT #
    #########################

    def draw_vertical(x,y1,y2,c)
        begin
            if y1 <= y2
                rows = @graph[y1..y2]
            else
                rows = @graph[y2..y1]
            end
            rows.each do |p|
                p[x] = c
            end
        rescue Exception
            STDERR.puts "Invalid input for draw_vertical"
        end
    end

    ###########################
    # DRAW HORIZONTAL SEGMENT #
    ###########################

    def draw_horizontal(x1,x2,y,c)
        begin
            row = @graph[y]
            if x1 <= x2
                line_length = x2 - x1 + 1
                row[x1..x2] = [c] * line_length
            else
                line_length = x1 - x2 + 1
                row[x2..x1] = [c] * line_length
            end
        rescue Exception
            STDERR.puts "Invalid input for draw_horizontal"
        end
    end

    #########################
    #       FILL TOOL       #
    #########################

    def fill_region(x,y,c)
        begin
            oc = @graph[y][x]
            @graph[y][x] = c
            fill_algorithm(x,y,c,oc)
        rescue Exception
            STDERR.puts "Invalid input for fill_region"
        end
    end

    def fill_algorithm(x,y,c,oc)
        begin
            (x-1..x+1).each do |newX|
                (y-1..y+1).each do |newY|
                    if @graph[newY]
                        if @graph[newY][newX] == oc
                            color_pixel(newX,newY,c)
                            fill_algorithm(newX, newY, c, oc)
                        end
                    end
                end
            end
        rescue Exception
            STDERR.puts "Invalid input for fill_algorithm"
        end
    end

    #########################
    #     PICTURE FRAME     #
    #########################

    def picture_frame(x1,y1,x2,y2,c)
        begin
            draw_horizontal(x1,x2,y1,c)
            draw_horizontal(x1,x2,y2,c)
            draw_vertical(x1,y1,y2,c)
            draw_vertical(x2,y1,y2,c)
        rescue Exception
            STDERR.puts "Invalid input for picture_frame"
        end
    end

    #########################
    #    FILLED RECTANGLE   #
    #########################
    def rectangle(x1,y1,x2,y2,c)
        begin
            if x1 < x2
                low_x = x1
                high_x = x2
            else 
                low_x = x2
                high_x = x1           
            end
            if y1 < y2
                low_y = y1
                high_y = y2
            else 
                high_y = y1
                low_y = y1
            end
            (low_x..high_x).each do |x|
                (low_y..high_y).collect{|y|@graph[y][x] = c}
            end
        rescue Exception
            STDERR.puts "Invalid input for rectangle"
        end          
    end
end