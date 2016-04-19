#=
Challenge #263 [Easy] Calculating Shannon Entropy of a String

Description

Shannon entropy was introduced by Claude E. Shannon in his 1948 paper "A
Mathematical Theory of Communication". Somewhat related to the physical and
chemical concept entropy, the Shannon entropy measures the uncertainty associated
with a random variable, i.e. the expected value of the information in the message
(in classical informatics it is measured in bits). This is a key concept in
information theory and has consequences for things like compression, cryptography
and privacy, and more.
The Shannon entropy H of input sequence X is calculated as -1 times the sum of
the frequency of the symbol i times the log base 2 of the frequency:

            n
            _   count(i)          count(i)
H(X) = -1 * >   --------- * log  (--------)
            -       N          2      N
            i=1

(That funny thing is the summation for i=1 to n. I didn't see a good way to do
this in Reddit's markup so I did some crude ASCII art.)
For more, see Wikipedia for Entropy in information theory).

Input Description

You'll be given a string, one per line, for which you should calculate the
Shannon entropy. Examples:

1223334444
Hello, world!

Output Description

Your program should emit the calculated entropy values for the strings to at least
five decimal places. Examples:

1.84644
3.18083

Challenge Input

122333444455555666666777777788888888
563881467447538846567288767728553786
https://www.reddit.com/r/dailyprogrammer
int main(int argc, char *argv[])

Challenge Output

2.794208683
2.794208683
4.056198332
3.866729296

(source: https://redd.it/4fc896)
=#

function __shannon_entropy( string::AbstractString )
    local frequency::Dict{Char, Integer} = Dict{Char, Integer}()

    for i in 1:length( string )
        if haskey( frequency, string[ i ] )
            frequency[ string[ i ] ] += 1
        else
            frequency[ string[ i ] ] = 1
        end
    end

    return frequency
end

function Shannon_entropy( string::AbstractString )
    local entropy::AbstractFloat = 0
    local frequency::Dict{Char, Integer} = __shannon_entropy( string )
    local N::Integer = length( string )

    for i in values( frequency )
        entropy += ( i/N ) * log2( i/N )
    end
    entropy *= -1

    return @sprintf "%.9f" entropy
end

println( Shannon_entropy( "1223334444" ) )
println( Shannon_entropy( "Hello, world!") )
println( Shannon_entropy( "122333444455555666666777777788888888") )
println( Shannon_entropy( "563881467447538846567288767728553786") )
println( Shannon_entropy( "https://www.reddit.com/r/dailyprogrammer") )
println( Shannon_entropy( "int main(int argc, char *argv[])") )
