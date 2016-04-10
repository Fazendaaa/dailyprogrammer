#=
Challenge #261 [Easy] verifying 3x3 magic squares

Description

A 3x3 magic square is a 3x3 grid of the numbers 1-9 such that each row, column,
and major diagonal adds up to 15. Here's an example:

8 1 6
3 5 7
4 9 2

The major diagonals in this example are 8 + 5 + 2 and 6 + 5 + 4. (Magic squares
have appeared here on r/dailyprogrammer before, in #65 [Difficult] in 2012.)
Write a function that, given a grid containing the numbers 1-9, determines whether
it's a magic square. Use whatever format you want for the grid, such as a
2-dimensional array, or a 1-dimensional array of length 9, or a function that
takes 9 arguments. You do not need to parse the grid from the program's input,
but you can if you want to. You don't need to check that each of the 9 numbers
appears in the grid: assume this to be true.

Example inputs/outputs

[8, 1, 6, 3, 5, 7, 4, 9, 2] => true
[2, 7, 6, 9, 5, 1, 4, 3, 8] => true
[3, 5, 7, 8, 1, 6, 4, 9, 2] => false
[8, 1, 6, 7, 5, 3, 4, 9, 2] => false

Optional bonus 1

Verify magic squares of any size, not just 3x3.

Optional bonus 2

Write another function that takes a grid whose bottom row is missing, so it only
has the first 2 rows (6 values). This function should return true if it's possible
to fill in the bottom row to make a magic square. You may assume that the numbers
given are all within the range 1-9 and no number is repeated. Examples:

[8, 1, 6, 3, 5, 7] => true
[3, 5, 7, 8, 1, 6] => false

Hint: it's okay for this function to call your function from the main challenge.
This bonus can also be combined with optional bonus 1. (i.e. verify larger magic
squares that are missing their bottom row.)

( source: https://redd.it/4dccix )
=#

read_matrix( data::DataType=Any, input::IO=STDIN, spacing::Char=' ' ) = readdlm(
input, spacing, data, header=false, skipblanks=true, ignore_invalid_chars=true,
quotes=false, comments=false )

function pseudo_magic_square( grid::Matrix{ Int } )
    local value::Bool = loop::Bool = false
    local missing::Int = tmp::Int = 0
    local last::Array{ Int, 1 } = Int[]

    for i in 1:size( grid, 2 )
        column = sum( grid[ :, i ] )
        missing = 15 - column
        push!( last, missing )

        if 9 >= missing
            for j in 1:size( grid, 1 ), k in 1:size( grid, 2 )
                if grid[ j, k ] == missing
                    loop = true
                    break
                end
            end
        else
            loop = true
        end

        if true == loop
            break
        end
    end

    if false == loop
        for i in 1:2
            tmp += grid[ i,i ]
        end
        tmp += last[ 3 ]
        if 15 == tmp
            value = true
        end
    end

    return value
end

function verify_magic_square( grid::Matrix{ Int } )
    local value::Bool = false
    local line::Integer = column::Integer = 0

    if 15 == trace( grid )  #   sums the value of the principal diagonal
        for i in 1:size( grid, 1 )
            line = sum( grid[ i, : ] )
            column = sum( grid[ :, i ] )
            if line != 15 || column != 15
                break
            elseif size( grid, 1 ) == i   #   if is the last verification and it's valid
                value = true
            end
        end
    end

    return value
end

#=
    I've modified the input format. So, that only be possibles input like:

        8 1 6                       8 1 6
        3 5 7           or          3 5 7
        4 9 2
=#
function main( )
    local input::Matrix{ Int } = read_matrix( Int )

    println( @time ( size( input, 1 ) == size( input, 2 ) ) ?
                     verify_magic_square( input ):
                     pseudo_magic_square( input ) )
end

main( )
