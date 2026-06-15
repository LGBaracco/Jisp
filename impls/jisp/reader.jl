module reader
export read_str

mutable struct Reader
    position::Int64
    tokens::Array
end

function next!(rdr::Reader)
    token = rdr.tokens[rdr.position]
    rdr.position += 1
    token
end

function peek(rdr::Reader)
    rdr.tokens[rdr.position]

end

function read_str(input::String)
    """Reads string and initialized Reader struct"""
    tokens = tokenize(input)
    if length(tokens) == 0
        return nothing
    end
    rdr = Reader(1, tokens)
    read_form(rdr)
end

function tokenize(input::String)
    [join(m.match) for m in eachmatch(r"[\s,]*(~@|[\[\]{}()'`~^@]|\"(?:\\.|[^\"])*\"?|;.*|[^\s\[\]{}('\"`,;)]*)", input)]
end

function read_form(rdr::Reader)
    if peek(rdr) == "("
        read_list(rdr)
    else
        read_atom(rdr)
    end
end

function read_list(rdr::Reader)
    parsed = []
    token = next!(rdr)
    while token != ")"
        push!(parsed, read_form(rdr))
    end
    next!(rdr)
    parsed
end

function read_atom(rdr::Reader)
    if match(r"^\d+$", peek(rdr)) !== nothing
        return parse(Int, peek(rdr))
    elseif match(r"^[+\-*/]$", peek(rdr)) !== nothing
        return Symbol(peek(rdr))
    end
end

end
