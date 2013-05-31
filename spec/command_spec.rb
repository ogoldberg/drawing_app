require "rspec"
require_relative "../drawing_app"

describe DrawingApp do
    before(:each) do
        @drawing_app = DrawingApp.new
    end


    describe "command interpreter" do 
        it "should instantiate with  5 columns and 8 rows" do
            @drawing_app.input("I 8 5")
            @drawing_app.columns.should == 8
            @drawing_app.rows.should == 5
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
end