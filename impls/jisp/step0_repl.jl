function READ(input)
    input
end

function EVAL(input)
    input
end

function PRINT(input)
    input
end

function rep(input)
    PRINT(EVAL(READ(input)))
end

while true
    print("user> ")
    line = readline()
    if line === nothing break end
    println(rep(line))
end