#=
Challenge #256 [Easy] Oblique and De-Oblique

The oblique function slices a matrix (2d array) into diagonals.
The de-oblique function takes diagonals of a matrix, and reassembles the original
rectangular one.

input for oblique

 0  1  2  3  4  5
 6  7  8  9 10 11
12 13 14 15 16 17
18 19 20 21 22 23
24 25 26 27 28 29
30 31 32 33 34 35
(and the output to de-oblique)

output for oblique

0
1 6
2 7 12
3 8 13 18
4 9 14 19 24
5 10 15 20 25 30
11 16 21 26 31
17 22 27 32
23 28 33
29 34
35
(and the input to de-oblique)

bonus deambiguated de-oblique matrices

There's only one de-oblique solution for a square matrix, but when the result is
not square, another input is needed to indicate whether the output should be tall
or wide or provide specific dimentsions of output:

rectangular oblique data input

0
1 6
2 7 12
3 8 13
4 9 14
5 10 15
11 16
17

output for (wide) deoblique (3 6, INPUT) or deoblique (WIDE, INPUT)

 0  1  2  3  4  5
 6  7  8  9 10 11
12 13 14 15 16 17

output for (tall) deoblique (6 3, INPUT) or deoblique (TALL, INPUT)

 0  1  2
 6  7  3
12  8  4
13  9  5
14 10 11
15 16 17

Note

The main use of these functions in computer science is to operate on the diagonals
of a matrix, and then revert it back to a rectangular form. Usually the rectangular
dimensions are known.

(source: https://redd.it/48a4pu)
=#

#   exit at EOF
read_matrix( data::DataType=Any, input::IO=STDIN, spacing::Char=' ' ) = readdlm(
input, spacing, data, header=false, skipblanks=true, ignore_invalid_chars=true,
quotes=false, comments=false )

function de_oblique( grid::Matrix{ Int } )
end

function oblique( grid::Matrix{ Int } )
    local len::Integer = size( grid, 1 )
    local line::Array{ Int, 1 } = Array{ Int, 1 }( )
    local tmp::Integer = 0
    local new_grid::Array{ Array{ Int, 1 }, 1 } = Array{ Array{ Int, 1 }, 1 }( )

    for i in 1:len
        tmp = i
        for j in 1: i
            push!( line, grid[ j , tmp ] )
            tmp -= 1
        end
        push!( new_grid, line )
        line = Array{ Int, 1 }( )
    end

    for i in 2:len
        tmp = i
        for j in len:-1:i
            push!( line, grid[ tmp, j ] )
            tmp += 1
        end
        push!( new_grid, line )
        line = Array{ Int, 1 }( )
    end

    return new_grid
end

function main( )
    local grid::Matrix{ Int } = read_matrix( Int )
    local new_grid::Array{ Array{ Int, 1 }, 1 } = Array{ Array{ Int, 1 }, 1 }( )
    local len::Integer = wid::Integer = 0
    ( len, wid ) = size( grid )

    if len != wid
        new_grid = de_oblique( grid )
    else
        new_grid = oblique( grid )
    end

    for i in 1:size( new_grid, 1 )
        println( new_grid[ i ] )
    end
end

main( )
