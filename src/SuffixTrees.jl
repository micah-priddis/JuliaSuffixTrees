

module SuffixTrees

include("SuffixNode.jl")



@enum findpathcase begin
    substringexists = 1
    mismatchonnode = 2
    mismatchonedge = 3
end


function findpath(root::SuffixNode, str::String, i )
    if(isleaf(root))
        return substringexists, root, 0 #string already exists in tree
    end

    child = nothing
    current = root.child

    #look through sibling list for next node to go to
    while !isnothing(current) 
        if str[current.firstchar] == str[i]
            child = current
        end
        current = current.sibling
    end

    #No child node was found with a matching character
    #Mismatch on node case
    if isnothing(child)
        return mismatchonnode, root, i
    end

    #Hop to the next node in the tree
    root = child

    j = child.firstchar
    length = length(str)
    while i < length && j <= child.lastchar
        #character match
        if str[i] == str[j]
            i += 1
            j += 1
        else #mismatch on edge
            return  mismatchonedge, root, i, j #No matching character found on edge at position i
        end
    end
    return findpath(root, str, i)


end


function insertsuffix!(root::SuffixNode, str, first, last)

    result = findpath(root, str, 1)
    if result[1] == substringexists
        return root
    elseif result[1] == mismatchonnode
        parent = result[2]
        leaf = SuffixNode(result[3], last, nothing, nothing, nothing)
        insertchild!(parent, leaf)
        return leaf
    elseif result[1] == mismatchonedge

        nodep = result[2]

        leaf = SuffixNode(result[3], last, nothing, nothing, nothing )
        internal = SuffixNode(nodep.firstchar, result[4] -1, nothing, nothing, nothing)

        internal.parent = nodep.parent
        removechildnode(internal.parent, nodep)

        insertchild!(internal, leaf)
        insertchild!(internal, nodep)
        insertchild!(internal.parent, internal)
        
        return leaf

    end

    return root
end

function buildtree(str::String)
    root = SuffixNode(0, 0, nothing, nothing, nothing)
    for i in 1:length(str)
        insertsuffix!(root, str, i, length(str))
    end
    
    return root
end


function issubstring(str1, str2)
    tree = buildtree(str1)
    if findpath(tree, str2, 1)[1] == substringexists
        return true
    end
    return false

end

println(issubstring("banana", "nana"))


end # module
