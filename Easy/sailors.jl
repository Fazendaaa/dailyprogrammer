#=
Challenge #252 [Easy] Sailors and monkeys and coconuts, oh my!

Description

A number of sailors (let's call it N) are stranded on an island with a huge pile
of coconuts and a monkey. During the night, each sailor (in turn) does the following
without the others knowing:
    1. He takes one N'th (e.g. if N=5, one fifth) of the coconuts in the pile and
    hides them
    2. The division leaves one coconut left over, which is given to the monkey.
In the morning, they split the remaining coconuts between them. This time the
split is even. There's nothing left over for the monkey.
Your task: Given the number of sailors (N), how many coconuts were in the pile
to begin with (lowest possible number)?

Formal inputs/outputs

Input

The input is a single number: N, the number of sailors. This number is a whole
number that is greater than or equal to 2.

Output

The output is a single number: the number of coconuts in the original pile.
Sample input/output

Input:
5
Output:
3121
Sample solution for 5 sailors: https://jsfiddle.net/722gjnze/8/

Credit

This challenge was originally suggested on /r/dailyprogrammer_ideas by
/u/TinyLebowski (prior to some changes by me). Have a cool challenge idea?
Hop on over to /r/dailyprogrammer_ideas to tell everyone about it!

( source: https://redd.it/43ouxy )
=#

how_many_coconut( N::Integer=2 ) = ( N^N - ( N - 1 ) )

function main( )
    local N::Integer = parse( Int, chomp( readline( STDIN ) ) )

    N >= 2 ? println( how_many_coconut( N ) ) : error( "Please, type a valid number: greater or equal to 2" )
end

main( )
