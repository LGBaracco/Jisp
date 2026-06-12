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
    rdr = Reader(0, tokenize(input))
    read_form(rdr)
end
function tokenize(input::String)
    [join(m.match) for m in eachmatch(r"[\s,]*(~@|[\[\]{}()'`~^@]|\"(?:\\.|[^\"])*\"?|;.*|[^\s\[\]{}('\"`,;)]*)", input)]
end

function read_form(rdr::Reader)
    accum = []
    if peek(rdr) == "("
        push!(accum, read_list(rdr))
    else
        return push!(accum, read_atom(rdr))
    end
end

function read_list(rdr::Reader)
    if next!(rdr) != ")"
        return read_form(rdr)
    end
end

function read_atom(rdr::Reader)
    if match(r"^\d+$", peek(rdr))
        return parse(Int, peek(rdr))
    elseif match(r"^[+\-*/]$", peek(rdr))
        return Symbol(peek(rdr))
    end
end

end
