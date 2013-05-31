class DrawingApp
    attr_reader :columns
    attr_reader :rows
    attr_reader :graph

    def initialize

    end

    def interface
        print "Input text: "
        input = gets.strip.upcase
        take_action
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
   end

   def input(command)
    input_array = command.split(' ')
    take_action(input_array)
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
        x = x - 1
        y1 = y1 -1
        y2 = y2 - 1
        rows = @graph[y1..y2]
        rows.each do |p|
            p[x] = c
        end
        show
    end

    def draw_horizontal

    end

    def fill_region

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
        case input[0]
        when "I"
            create_new_image(input[1].to_i, input[2].to_i)
        when "C"
            clear_table
        when "L"
            color_pixel(input[1].to_i, input[2].to_i, input[3])
        when "V"
           draw_vertical(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
        when "H"
            draw_horizontal
        when "F"
            fill_region
        when "S"
            show
        when "X"
            terminate_session
        end
    end
end