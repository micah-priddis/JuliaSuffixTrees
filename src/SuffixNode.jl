"""
The SuffixNode struct represents the nodes to be used within
the suffix tree. These nodes will be used to form a compressed trie
to hold all unique suffixes of a string. Conceptually, each node
can be thought of as containing a substring. However, to avoid storing
redundant strings, each substring is stored as the Julia type, "SubString"
which references the original string to reduce memory usage.
"""
mutable struct SuffixNode
    firstchar::Unsigned
    lastchar::Unsigned
    child::Union{SuffixNode, Nothing}
    sibling::Union{SuffixNode, Nothing}
    parent::Union{SuffixNode, Nothing}
    
end

function isleaf(node::SuffixNode)
    if isnothing(node.child)
        return true
    end
    return false
end

#for now the child is always inserted at the beginning of the sibling list
function insertchild!(parent::SuffixNode, child::SuffixNode)
    child.parent = parent
    child.sibling = parent.child
    parent.child = child
end

function printsiblinglist(firstnode::SuffixNode, str)
    node = firstnode
    while !isnothing(node)
        println(str[node.firstchar])
        node = node.sibling
        
    end
end

function removechildnode(parent, child)

    node = parent.child
    while !isnothing(node.sibling)
        if node.sibling === child
            node.sibling = node.sibling.sibling
            return true
        end
        node = node.sibling
    end
    return false
end