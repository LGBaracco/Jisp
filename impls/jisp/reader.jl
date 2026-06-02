module reader

struct Reader
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
    Reader(0, tokenize(input))
end

function tokenize(input::String)
    [m.match for m in eachmatch(r"[\s,]*(~@|[\[\]{}()'`~^@]|\"(?:\\.|[^\"])*\"?|;.*|[^\s\[\]{}('\"`,;)]*)", input)]
end

# TODO implement the array accumulation, might need to un-ternary this thing and use recursion
function read_form(rdr::Reader)
    if peek(rdr) == "("
        return read_list(rdr)
    else
        return read_atom(rdr)
    end
end

function read_list(rdr::Reader)
    if next!(rdr) != ")"
        read_form(rdr)
    end
end

function read_atom(rdr::Reader)
    token = peek(rdr)
    if match(r"^\d+$", token)
        return Int64
    elseif match(r"^[+\-*/]$", token) 
        return 
    end
end

end
