require "rspec"
require_relative "../drawing_app"

describe DrawingApp do
    before(:each) do
        @drawing_app = DrawingApp.new
    end

    describe "create graph" do
        it "should have 12 pixels" do
            @drawing_app.create_new_image(4,3)
            expected_graph = [["O", "O", "O", "O"], ["O", "O", "O", "O"],["O", "O", "O", "O"]]
            @drawing_app.graph.should == expected_graph
        end
    end

    describe "clear table" do
        it "should make all pixels white" do
            @drawing_app.create_new_image(4,3)
            @drawing_app.graph[2].map! {|p| p = "X"}
            @drawing_app.clear_table
            expected_graph = [["O", "O", "O", "O"], ["O", "O", "O", "O"],["O", "O", "O", "O"]]
            @drawing_app.graph.should == expected_graph
        end
    end

    describe "color pixel" do
        it "should change the color of a specific pixel" do
            @drawing_app.create_new_image(4,3)
            @drawing_app.color_pixel(3,2,"y")
            expected_graph = [["O", "O", "O", "O"], ["O", "O", "Y", "O"],["O", "O", "O", "O"]]
            @drawing_app.graph.should == expected_graph
        end
    end

    describe "draw_vertical" do
        it "should draw a vertical line" do
            @drawing_app.create_new_image(4,3)
            @drawing_app.draw_vertical(2,1,3,"r")
            expected_graph = [["O", "R", "O", "O"], ["O", "R", "O", "O"],["O", "R", "O", "O"]]
            @drawing_app.graph.should == expected_graph
        end
    end

    describe "draw_horizontal" do
        it "should draw a horizontal line with x1 < x2" do
            @drawing_app.create_new_image(4,3)
            @drawing_app.draw_horizontal(3,1,3,"g")
            expected_graph = [["O", "O", "O", "O"], ["O", "O", "O", "O"],["G", "G", "G", "O"]]
            @drawing_app.graph.should == expected_graph
        end

        it "should draw a horizontal line with x1 > x2" do
            @drawing_app.create_new_image(4,3)
            @drawing_app.draw_horizontal(1,3,3,"G")
            expected_graph = [["O", "O", "O", "O"], ["O", "O", "O", "O"],["G", "G", "G", "O"]]
            @drawing_app.graph.should == expected_graph
        end
    end

    describe "fill tool" do
        it "should fill a closed square" do
            @drawing_app.create_new_image(3,3)
            @drawing_app.graph[0] = ["C", "C", "C"]
            @drawing_app.graph[1] = ["C", "A", "C"]
            @drawing_app.graph[2] = ["C", "A", "C"]
            @drawing_app.fill_region(2, 2, "b")
            expected_graph = [["C", "C", "C"], ["C", "B", "C"],["C", "B", "C"]]
            @drawing_app.graph.should == expected_graph
        end

        it "should leak out of a top right open cornered square" do
            @drawing_app.create_new_image(4,4)
            @drawing_app.graph[0] = ["C", "C", "C", "C"]
            @drawing_app.graph[1] = ["M", "M", "C", "C"]
            @drawing_app.graph[2] = ["M", "C", "M", "C"]
            @drawing_app.graph[3] = ["M", "M", "M", "C"]
            @drawing_app.fill_region(2, 3, "b")
            expected_graph = [["B", "B", "B", "B"], ["M", "M", "B", "B"],["M", "B", "M", "B"],["M", "M", "M", "B"]]
            @drawing_app.graph.should == expected_graph
        end

        it "should leak out of a top left open cornered square" do
            @drawing_app.create_new_image(4,4)
            @drawing_app.graph[0] = ["C", "C", "C", "C"]
            @drawing_app.graph[1] = ["C", "M", "M", "C"]
            @drawing_app.graph[2] = ["M", "C", "M", "C"]
            @drawing_app.graph[3] = ["M", "M", "M", "C"]
            @drawing_app.fill_region(2, 3, "b")
            expected_graph = [["B", "B", "B", "B"], ["B", "M", "M", "B"],["M", "B", "M", "B"],["M", "M", "M", "B"]]
            @drawing_app.graph.should == expected_graph
        end

        it "should leak out of a bottom left open cornered square" do
            @drawing_app.create_new_image(4,4)
            @drawing_app.graph[0] = ["C", "C", "C", "C"]
            @drawing_app.graph[1] = ["C", "M", "M", "M"]
            @drawing_app.graph[2] = ["C", "M", "C", "M"]
            @drawing_app.graph[3] = ["C", "C", "M", "M"]
            @drawing_app.fill_region(3, 3, "b")
            expected_graph = [["B", "B", "B", "B"], ["B", "M", "M", "M"],["B", "M", "B", "M"],["B", "B", "M", "M"]]
            @drawing_app.graph.should == expected_graph            
        end

        it "should leak out of a bottom right open cornered square" do
            @drawing_app.create_new_image(4,4)
            @drawing_app.graph[0] = ["C", "C", "C", "C"]
            @drawing_app.graph[1] = ["M", "M", "M", "C"]
            @drawing_app.graph[2] = ["M", "C", "M", "C"]
            @drawing_app.graph[3] = ["M", "M", "C", "C"]
            @drawing_app.fill_region(2, 3, "b")
            expected_graph = [["B", "B", "B", "B"], ["M", "M", "M", "B"],["M", "B", "M", "B"],["M", "M", "B", "B"]]
            @drawing_app.graph.should == expected_graph
        end
    end

    describe "picture_frame tool" do
        it "should draw a rectangle" do
            @drawing_app.create_new_image(4,4)
            @drawing_app.picture_frame(1,1,3,3,"F")
            expected_graph = [["F", "F", "F", "O"], ["F", "O", "F", "O"],["F", "F", "F", "O"],["O", "O", "O", "O"]]
            @drawing_app.graph.should == expected_graph
        end
    end

    describe "rectangle tool" do
        it "should draw a filled rectangle" do
            @drawing_app.create_new_image(4,4)
            @drawing_app.rectangle(3,1,1,3,"F")
            expected_graph = [["F", "F", "F", "O"], ["F", "F", "F", "O"],["F", "F", "F", "O"],["O", "O", "O", "O"]]
        end
    end
end






