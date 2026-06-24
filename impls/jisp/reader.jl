module reader
export read_str

# TODO just finished the read list, now everything else (included printer)

mutable struct Reader
    position::Int64
    tokens::Array
end

function next!(rdr::Reader)
    token = rdr.tokens[rdr.position]
    rdr.position += 1
    token
end

function peeknext(rdr::Reader)
    rdr.tokens[rdr.position+1]
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
    [join(strip(m.match, ' ')) for m in eachmatch(r"[\s,]*(~@|[\[\]{}()'`~^@]|\"(?:\\.|[^\"])*\"?|;.*|[^\s\[\]{}('\"`,;)]*)", input)]
end

function read_form(rdr::Reader)
    if peek(rdr) == "("

        read_list(rdr)
    else
        read_atom(rdr)
    end
end

a = read_str("( 1 2 3 )")

function read_list(rdr::Reader)
    parsed = []
    while peeknext(rdr) != ")"
        next!(rdr)
        push!(parsed, read_form(rdr))
    end
    parsed
end

function read_atom(rdr::Reader)
    if match(r"^\d+$", peek(rdr)) !== nothing
        parse(Int, peek(rdr))
    elseif match(r"^[+\-*/]$", peek(rdr)) !== nothing
        symbol(peek(rdr))
    end
end

end
