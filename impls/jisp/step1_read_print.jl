include("reader.jl")
include("printer.jl")

function READ(input)
    reader.read_str(input)
end

function EVAL(input)
    input
end

function PRINT(input)
    printer.pr_str(input)
end

function rep(input)
    PRINT(EVAL(READ(input)))
end

while true
    print("user> ")
    line = readline()
    if line === nothing
        break
    end
    println(rep(line))
end
