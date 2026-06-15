module printer
export pr_str

function pr_str(ast)
    output = ""#"("
    if isa(ast, Array)
        output = output * pr_str(ast)
    else
        output = output * string(ast)
    end
    output
end

end