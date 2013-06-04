require "rspec"
require_relative "../drawing_app"

describe DrawingApp do
    before(:each) do
        @drawing_app = DrawingApp.new
    end


    describe "command interpreter" do 
        it "should instantiate with 5 columns and 8 rows" do
            @drawing_app.create_new_image(8,5)
            # @drawing_app.columns.should == 8
            # @drawing_app.rows.should == 5
        end
    end

    describe "create graph" do
        it "should have 40 pixels" do
            @drawing_app.create_new_image(8,5)
            @drawing_app.graph.count.should == 5
            @drawing_app.graph.each do |c| 
                c.count.should == 8
            end
        end
    end

    describe "clear table" do
        it "should make all pixels white" do
            @drawing_app.create_new_image(8,5)
            @drawing_app.graph[4].map! {|p| p = "X"}
            @drawing_app.clear_table
            @drawing_app.graph.each do |r|
                r.each do |p|
                    p.should == "O"
                end
            end
        end
    end

    describe "color pixel" do
        it "should change the color of a specific pixel" do
            @drawing_app.create_new_image(8,5)
            @drawing_app.color_pixel(3,4,"Y")
            @drawing_app.graph[3][2].should == "Y"
            puts @drawing_app.graph[3][2].inspect
            @drawing_app.graph[1][1].should_not == "Y"
            puts @drawing_app.graph[1][1].inspect
            @drawing_app.show
        end
    end

    describe "draw_vertical" do
        it "should draw a vertical line" do
            @drawing_app.create_new_image(8,5)
            @drawing_app.draw_vertical(2,1,4,"R")
            rows =  [@drawing_app.graph[0], @drawing_app.graph[1], @drawing_app.graph[2], @drawing_app.graph[3]]
            rows.each do |p|
                p[1].should == "R"
            end
            @drawing_app.graph[0][0].should_not == "R"
        end
    end

    describe "draw_horizontal" do
        it "should draw a horizontal line with x1 < x2" do
            @drawing_app.create_new_image(8,5)
            @drawing_app.draw_horizontal(1,6,4,"G")

            @drawing_app.graph[3][0..5].each do |p|
                p.should == "G"
            end
            @drawing_app.graph[3][6].should_not == "G"
        end

        it "should draw a horizontal line with x1 > x2" do
            @drawing_app.create_new_image(8,5)
            @drawing_app.draw_horizontal(6,3,2,"G")

            @drawing_app.graph[1][2..5].each do |p|
                p.should == "G"
            end
            @drawing_app.graph[3][6].should_not == "G"
        end
    end

    describe "fill tool" do
        it "should fill a closed square" do
            @drawing_app.create_new_image(20,20)
            @drawing_app.draw_horizontal(4,15,4,"G")
            @drawing_app.draw_horizontal(4,15,14,"G")
            @drawing_app.draw_vertical(4,4,14, "G")
            @drawing_app.draw_vertical(15,4,14, "G")
            @drawing_app.color_pixel(7,8,"Y")
            @drawing_app.fill_region(10,11, "B")
            @drawing_app.graph[4][4..13].each do |p|
                p.should == "B"
            end
            @drawing_app.graph[3][4..13].each do |p|
                p.should == "G"
            end
        end

        it "should leak out of an top right open cornered square" do
            @drawing_app.create_new_image(20,20)
            @drawing_app.draw_horizontal(4,14,4,"G")
            @drawing_app.draw_horizontal(4,15,14,"G")
            @drawing_app.draw_vertical(4,4,14, "G")
            @drawing_app.draw_vertical(15,5,14, "G")
            @drawing_app.color_pixel(7,8,"Y")
            @drawing_app.fill_region(10,11, "B")
            @drawing_app.graph[4][4..13].each do |p|
                p.should == "B"
            end
            @drawing_app.graph[3][4..13].each do |p|
                p.should == "G"
            end
        end

        it "should leak out of a top left open cornered square" do
            @drawing_app.create_new_image(20,20)
            @drawing_app.draw_horizontal(5,15,4,"G")
            @drawing_app.draw_horizontal(4,15,14,"G")
            @drawing_app.draw_vertical(4,5,14, "G")
            @drawing_app.draw_vertical(15,5,14, "G")
            @drawing_app.color_pixel(7,8,"Y")
            @drawing_app.fill_region(10,11, "B")
            @drawing_app.graph[4][4..13].each do |p|
                p.should == "B"
            end
            @drawing_app.graph[3][4..13].each do |p|
                p.should == "G"
            end
        end

        it "should leak out of a bottom left open cornered square" do
            @drawing_app.create_new_image(20,20)
            @drawing_app.draw_horizontal(4,15,4,"G")
            @drawing_app.draw_horizontal(5,15,14,"G")
            @drawing_app.draw_vertical(4,4,13, "G")
            @drawing_app.draw_vertical(15,5,14, "G")
            @drawing_app.color_pixel(7,8,"Y")
            @drawing_app.fill_region(10,11, "B")
            @drawing_app.graph[4][4..13].each do |p|
                p.should == "B"
            end
            @drawing_app.graph[3][4..13].each do |p|
                p.should == "G"
            end
        end

        it "should leak out of a bottom right open cornered square" do
            @drawing_app.create_new_image(20,20)
            @drawing_app.draw_horizontal(4,15,4,"G")
            @drawing_app.draw_horizontal(5,14,14,"G")
            @drawing_app.draw_vertical(4,4,14, "G")
            @drawing_app.draw_vertical(15,5,13, "G")
            @drawing_app.color_pixel(7,8,"Y")
            @drawing_app.fill_region(10,11, "B")
            @drawing_app.graph[4][4..13].each do |p|
                p.should == "B"
            end
            @drawing_app.graph[3][4..13].each do |p|
                p.should == "G"
            end
        end
    end

end






