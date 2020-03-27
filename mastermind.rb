class Mastermind
    def initialize
        @colors = ["blue", "green", "orange", "purple", "red", "yellow"]
    end

    def play
        choice
        if @position != "1" && @position != "2"
            play
        end
        if @position == "1"
            codemakerz
        else
            codebreakerz
        end
    end

    private

    def choice
        puts "Enter 1 for Codemaker and 2 for Codebreaker"
        @position = gets.chomp
    end

    def codebreakerz
        @rounds = 0
        @gamewin = false
        makecode
        instructions
        while @rounds <= 10 && !@gamewin
            guess
            check
        end
        if @rounds > 10
            puts "You Lost, this is the code"
            puts @board
        end
    end

    def makecode
        @board = 4.times.map { @colors.sample }
    end

    def instructions
        puts "Enter your code in numbers"
        puts "1 = blue"
        puts "2 = green"
        puts "3 = orange"
        puts "4 = purple"
        puts "5 = red"
        puts "6 = yellow"
        puts "example code = 1124"
    end

    def guess
        @guess = gets.chomp
        @array = @guess.split("")
        @convert = []
        if @guess.length != 4
            puts "Please enter 4 digits"
            return guess
        end
        @array.each do |x|
            case x
            when "1"
                @convert.push("blue")
            when "2"
                @convert.push("green")
            when "3"
                @convert.push("orange")
            when "4"
                @convert.push("purple")
            when "5"
                @convert.push("red")
            when "6"
                @convert.push("yellow")
            else
                puts "Please only enter digits that are between 1-6"
                return guess
            end
        end
    end

    def check
        @rounds += 1
        checker = @board.map(&:clone)
        @placeholder = @convert.map(&:clone)
        @position = 0
        @color = 0
        @placeholder.each_with_index do |x, y| 
            if checker[y] == x
                checker[y] = "empty"
                @placeholder[y] = "nope"
                @position += 1
            end
        end
        @placeholder.each_with_index do |x, y|
            if checker.include?(x)
                @color += 1
                @placeholder[y] = "nope"
                checker[checker.find_index(x)] = "empty"
            end
        end
        if @convert == @board
            puts "You won in #{@rounds} rounds"
            @gamewin = true
        end
        puts "You got #{@position} positions's correct and #{@color} are present in the solution"
    end

    def codemakerz
        @rounds = 0
        @gamewin = false
        instructions
        guess
        @complete = ["", "", "", ""]
        @board = @convert
        while @rounds <= 10 && !@gamewin
            computer
        end
        if @rounds > 10
            puts "Computer could not break the code."
        end
    end

    def computer
        @rounds += 1
        checker = @board.map(&:clone)
        @computerguess = 4.times.map { @colors.sample }
        @computerguess.each_with_index do |x, y|
            if @holder != ""
            @computerguess[y] = @holder
            end
        end
        @complete.each_with_index do |x, y|
            if x != ""
                @computerguess[y] = x
            end
        end
        @holder = ""
        @placeholder = @computerguess.map(&:clone)
        @position = 0
        @color = 0
        puts @computerguess
        @placeholder.each_with_index do |x, y| 
            if checker[y] == x
                checker[y] = "empty"
                @complete[y] = x
                @placeholder[y] = "nope"
                @position += 1
            end
        end
        @placeholder.each_with_index do |x, y|
            if checker.include?(x)
                @color += 1
                @placeholder[y] = "nope"
                checker[checker.find_index(x)] = "empty"
                @holder = x
            end
        end
        if @complete == @board
            puts "The computer won in #{@rounds} rounds"
            @gamewin = true
        end
        puts "Computer got #{@position} positions's correct and #{@color} are present in the solution"
    end
end
Mastermind.new.play