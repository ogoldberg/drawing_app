class String
    # colorization  
    def colorize(color_code)
        "\e[#{color_code}m#{self}\e[0m"
    end

    def color_chooser(p)
        case p
        when "B"
            blue
        when "K"
            black
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
        when "b"
            l_blue
        when "k"
            l_black
        when "c"
            l_cyan
        when "g"
            l_green
        when "m"
            l_magenta
        when "o"
            l_white
        when "r"
            l_red      
        when "y"
            l_yellow
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

    def l_blue
        colorize(34)
    end

    def l_black
        colorize(30)
    end

    def l_cyan
        colorize(36)
    end

    def l_green
        colorize(32)
    end

    def l_magenta
        colorize(35)
    end

    def l_white
        colorize(37)
    end

    def l_red
        colorize(31)
    end    

    def l_yellow
        colorize(33)
    end  

end