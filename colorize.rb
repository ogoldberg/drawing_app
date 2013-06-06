class String
    # colorization  
    def colorize(color_code)
        "\e[#{color_code}m#{self}\e[0m"
    end

    def color_chooser(p)
        case p
        when "B"
            blue
        when "C"
            cyan
        when "G"
            green
        when "M"
            magenta
        when "O"
            white
        when "R"
            red      
        when "Y"
            yellow
        end
    end

    private

    def blue
        colorize(44)
    end

    def black
        colorize(40)
    end

    def cyan
        colorize(46)
    end

    def green
        colorize(42)
    end

    def magenta
        colorize(45)
    end

    def white
        colorize(47)
    end

    def red
        colorize(41)
    end    

    def yellow
        colorize(43)
    end  

end