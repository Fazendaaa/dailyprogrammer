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

#   exit at EOF ( in Linux: Ctrl + D and Windows: Ctrl + Z )
read_matrix( data::DataType=Any, input::IO=STDIN, spacing::Char=' ' ) = readdlm(
input, spacing, data, header=false, skipblanks=true, ignore_invalid_chars=true,
quotes=false, comments=false )

magic_N( N::Int ) = convert( Int, N*( N^2+1 )/2 )

function swap_grid_line!( grid::Matrix{ Int }, i::Integer, j::Integer )
    #   @inbounds allows the operation without bounding checking -- great time
    #   saving
    @inbounds for k in 1:size( grid, 2 )
        grid[ i, k ], grid[ j, k ] = grid[ j, k ], grid[ i, k ]
    end
end

#=
    This function basically does the interpolation of a determinated line and see
    all the combinations, if the combination is valid or not
=#
function __magic_square!( grid::Matrix{ Int }, magic::Int, index::Int=1 )
    if index + 1 >= size( grid, 1 )
        return grid
    else
        for p in __magic_square!( grid, magic, index+1 )
            produce( p )
            return p
        end

        for i in index+1:size( grid, 1 )
            swap_grid_line!( grid, index, i )
            for p in __magic_square!( grid, magic, index+1 )
                produce( p )
            end
            swap_grid_line!( grid, index, i )
        end
    end
end

#=
    This function call __magic_square! each time with each line of the grid to
    check up all the combinations -- when the solutions is found returns the
    the grid
=#
function magic_square!( grid::Matrix{ Int } )
    local magic::Int = magic_N( size( grid, 1 ) )
    local counter::Int = 1

    for i in 1:size( grid, 1 )
        task = @task __magic_square!( grid, magic, i )
        for n in task
            nothing
        end
    end

    return grid
end

function main( )
    local matrix::Matrix{ Int } = read_matrix( Int )
    println( @time magic_square!( matrix ) )
    println( "The magic number is ", magic_N( size( matrix, 1 ) ), " and your diagonal adds up to ", trace( matrix ) )
end

main( )
