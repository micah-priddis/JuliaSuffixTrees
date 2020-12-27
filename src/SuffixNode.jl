"""
The SuffixNode struct represents the nodes to be used within
the suffix tree. These nodes will be used to form a compressed trie
to hold all unique suffixes of a string. Conceptually, each node
can be thought of as containing a substring. However, to avoid storing
redundant strings, each substring is represented by two indexes pointing
to the first and last characters in the substrings.



"""

mutable struct SuffixNode
    first::Unsigned #Index of the first letter in the node's string
    last::Unsigned #Index of the last letter in the node's string
    len::Unsigned # len = last - first + 1
    child::SuffixNode
    sibling::SuffixNode
    
end