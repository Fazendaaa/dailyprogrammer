#=
[Intermediate] rearranged magic squares

Description

An NxN magic square is an NxN grid of the numbers 1 through N^2 such that each row,
column, and major diagonal adds up to M = N(N^2+1)/2. See this week's Easy problem
for an example.
You will be given an NxN grid that is not a magic square, but whose rows can be
rearranged to form a magic square. In this case, rearranging the rows means to
put the rows (horizontal lines of numbers) in a different order, but within each
row the numbers stay the same. So for instance, the top row can be swapped with
the second row, but the numbers within each row cannot be moved to a different
position horizontally, and the numbers that are on the same row as each other
to begin with must remain on the same row as each other.
Write a function to find a magic square formed by rearranging the rows of the
given grid.
There is more than one correct solution. Format your grid however you like. You
can parse the program's input to get the grid, but you don't have to.

Example

15 14  1  4        12  6  9  7
12  6  9  7   =>    2 11  8 13
 2 11  8 13        15 14  1  4
 5  3 16 10         5  3 16 10

Inputs

Challenge inputs

Any technique is going to eventually run too slowly when the grid size gets too
large, but you should be able to handle 8x8 in a reasonable amount of time (less
than a few minutes). If you want more of a challenge, see how many of the example
inputs you can solve.
I've had pretty good success with just randomly rearranging the rows and checking
the result. Of course, you can use a "smarter" technique if you want, as long as
it works!

Optional bonus

(Warning: hard for 12x12 or larger!) Given a grid whose rows can be rearranged to
form a magic square, give the number of different ways this can be done. That is,
how many of the N! orderings of the rows will result in a magic square?
If you take on this challenge, include the result you get for as many of the
challenge input grids as you can, along with your code.

( source: https://redd.it/4dmm44 )
=#

#   exit at EOF
read_matrix( data::DataType=Any, input::IO=STDIN, spacing::Char=' ' ) = readdlm(
input, spacing, data, header=false, skipblanks=true, ignore_invalid_chars=true,
quotes=false, comments=false )

magic_N( N::Int ) = convert( Int, N*( N^2 + 1 )/2 )

function copy_grid_line!( grid::Matrix{ Int }, src::Integer, dst::Integer )
    @inbounds for k in 1:size( grid, 2 )
        grid[ dst, k ] = grid[ src, k ]
    end
end

function swap_grid!( grid::Matrix{ Int }, index::Int )
    local tmp::Array{ Int, 1 } = Array( Int, 1 )
    local N::Int = size( grid, 2 )

    tmp = ( N != index ) ? deepcopy( vec( grid[ N, : ] ) ):
                           deepcopy( vec( grid[ N - 1, : ] ) )

    for i in N-1:-1:1
        if i != index
            i+1 != index ? copy_grid_line!( grid, i, i+1 ):
                           copy_grid_line!( grid, i, i+2 )
        else
            if 1 == i
                grid[ 2, : ] = deepcopy( tmp )
            else
                copy_grid_line!( grid, i-1, i+1 )
            end
        end
    end

    if 1 != index
        grid[ 1, : ] = deepcopy( tmp )
    end
end

function __magic_square!( grid::Matrix{ Int }, index::Int, magic::Int )
    for _ in 1:size( grid, 1 )
        trace( grid ) == magic ? break : swap_grid!( grid, index )
    end
end

function magic_square!( grid::Matrix{ Int } )
    local magic::Int = magic_N( size( grid, 1 ) )

    for i in 1:size( grid, 1 )
        trace( grid ) == magic ? break : __magic_square!( grid, i, magic )
    end

    return grid
end

function main( )
    local matrix::Matrix{ Int } = read_matrix( Int )
    println( @time magic_square!( matrix ) )
    println( "The magic number is ", magic_N( size( matrix, 1 ) ), " and your diagonal adds up to ", trace( matrix ) )
end

main( )
