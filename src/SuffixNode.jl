"""
The SuffixNode struct represents the nodes to be used within
the suffix tree. These nodes will be used to form a compressed trie
to hold all unique suffixes of a string. Conceptually, each node
can be thought of as containing a substring. However, to avoid storing
redundant strings, each substring is stored as the Julia type, "SubString"
which references the original string to reduce memory usage.



"""

mutable struct SuffixNode
    str::SubString
    child::Union{SuffixNode, Nothing}
    sibling::Union{SuffixNode, Nothing}
    
end