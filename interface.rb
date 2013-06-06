require_relative './drawing_app'
require_relative './colorize'
require 'yaml'
class Interface
    attr_reader :x
    attr_reader :y
    def initialize
        @drawing_app = DrawingApp.new
        @t = Psych.load_file('text.yaml')
        help
    end

    def help
        if @drawing_app.graph
            @t["help_text"].each {|k,v| puts v}
        else
            puts @t["help_text"]["i"]
            puts @t["example_text"]["i"]
            puts @t["help_text"]["x"]
            get_input
        end
        get_input
    end

    def get_input
        puts "\n"
        puts @t["prompt_text"][1]
        input = gets.strip
        process_input(input)
    end

    def process_input(input)
        input = input.split(' ')
        if @drawing_app.graph
            @options = ['I', 'C', 'L', 'V', 'H', 'F', 'R', 'D', 'P', 'S', 'M', 'X']
            if valid_action?(input)
                input[0] == "I" ? new_graph_sequence(input) : existing_graph_sequence(input)
            end            
        else
            @options = ['I', 'X']
            valid_action?(input) ? new_graph_sequence(input) : help
        end
    end

    def valid_action?(input)
        begin
            input[0] = input[0].upcase
            if @options.include? input[0]
                if input[0] == 'X'
                    puts "Thanks for using this graphing program!"
                    exit
                else 
                    true
                end
            else
                help
            end
        rescue
            help
        end            
    end

    def new_graph_sequence(input)     
        input[1] = (input[1].to_i) - 1   
        m_valid?(input)
        input[2] = (input[2].to_i) - 1
        n_valid?(input)        
        take_action(input)
    end

    def existing_graph_sequence(input)
        if (input[0] != "S") && (input[0] != "C")
            input[1] = input[1].to_i
            input[0] == "D" ? y_valid?(input[1]) : x_valid?(input[1])
            input[1] = input[1] - 1
            inconsistent_array_element_valid?(input)
        end
        take_action(input)
    end

    def inconsistent_array_element_valid?(input)
        input[2] = input[2].to_i
        if ["I", "L", "V", "F", "P", "R", "D"].include? input[0]
            y_valid?(input[2])
            input[2] = input[2]- 1
        else
            x_valid?(input[2])
            input[2] = input[2] - 1
            true
        end
        if ["L", "F", "D"].include? input[0]
            c_valid?(input[3])
            input[3] = input[3].upcase
        elsif ["V", "H"].include? input[0]
            input[3] = (input[3].to_i) - 1
            y_valid?(input[3])
            c_valid?(input[4])
            input[4] = input[4].upcase
            true
        elsif ["P", "R"].include? input[0]
            input[3] = (input[3].to_i) - 1
            input[4] = (input[4].to_i) - 1
            x_valid?(input[3])
            y_valid?(input[4])
            c_valid?(input[5])
            input[5] = input[5].upcase
            true
        end
    end

    def c_valid?(c)
        begin
            if ["B", "K", "C", "G", "M", "O", "R", "Y"].include? c.upcase
            else
                puts @t["error_text"]["c"]
                get_input
            end
        rescue
            puts @t["error_text"]["c"]
            get_input
        end
    end

    def y_valid?(y)
        n_valid?(y)
        begin
            y <= @drawing_app.rows ? true : y_error
        rescue
            x_error
        end
    end

    def x_valid?(x)
        m_valid?(x)
        begin
            x <= @drawing_app.columns ? true : x_error
        rescue
            x_error
        end
    end

    def m_valid?(m)
        if m.kind_of? Array
            if m[1].to_i > 0
            else
                puts @t["error_text"]["m"]
                get_input
            end
        else
            m.to_i > 0 ? true : x_error
        end
    end

    def n_valid?(n)
        if n.kind_of? Array
            if (n[2].to_i > 0) && (n[2].to_i < 250)
            else
                puts @t["error_text"]["n"]
                get_input
            end
        else
            (n.to_i > 0) && (n.to_i < 250) ? true : y_error
        end
    end

    def show
        @drawing_app.graph.each do |r|
            puts r.map { |p| p}.join("")
        end
        puts "\n"
        @drawing_app.graph.each do |r|
            puts r.map { |p| p.downcase.color_chooser(p)}.join("")
        end
        puts "\n"
        @drawing_app.graph.each do |r|
            puts r.map { |p| "\ ".color_chooser(p)}.join("")
        end
        get_input
        puts "\n"
    end

    def take_action(input)
        case input[0]
        when "I"
            @drawing_app.create_new_image(input[1],input[2])
        when "C"
            @drawing_app.clear_table
        when "L"            
            @drawing_app.color_pixel(input[1], input[2], input[3])
        when "V"
            @drawing_app.draw_vertical(input[1], input[2], input[3], input[4])
        when "H"
            @drawing_app.draw_horizontal((input[1]), (input[2]), (input[3]), input[4])
        when "F"
            @drawing_app.fill_region((input[1]), (input[2]), input[3])
        when "P"
            @drawing_app.picture_frame(input[1], input[2], input[3], input[4], input[5])
        when "R"
            @drawing_app.rectangle(input[1], input[2], input[3], input[4], input[5])               
        when "D"            
            @drawing_app.diagonal((input[1]), (input[2]), input[3])
        when "S"
            show
        else
            help
        end
        show
    end

    private

    def x_error
        puts "**ERROR: An integer between 1 and #{@drawing_app.columns + 1} must be submitted for value X **\n Please try again"
        get_input
    end

    def y_error
        puts "**ERROR An integer between 1 and #{@drawing_app.rows + 1} must be submitted for value Y **\n Please try again"
        get_input
    end
end
@interface = Interface.new