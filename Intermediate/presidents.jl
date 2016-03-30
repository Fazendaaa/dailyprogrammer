#=
Description

US presidents serve four year terms, with most presidents serving one or two terms.
Unless a president dies in office, they then live after leaving office.
This challenge, then, given a list of presidents and their dates of birth and dates
of death, is to figure out what year the most presidents - future, present, or
previous - were alive.

Challenge Input

In a CSV input of presidential birthdates and death dates. Find what year
in which the most number of people who would serve, are serving, or have served
as presidents. The answer might be multiple years, or only a partial year.

Challenge Output

Any of the following years is valid: 1822, 1823, 1824, 1825, 1826, 1831, 1833,
1834, 1835, 1836, 1837, 1838, 1839, 1840, 1841, 1843, 1844, 1845 (each year had
18 presidents, current, former, or to be, alive).
=#

using DataFrames

type President
    birth_year::Integer
    death_year::Integer
end

function main( )
    local data = readtable( "presidents.csv", header=true )
    local n_rows::Integer = n_cols::Integer = time::Integer = count::Integer = index::Integer = 0
    local all_presidents = President[]

    ( n_rows, n_cols ) = size( data )

    for i in 1:n_rows
        birth_year::Integer = parse( Int,( match( r"\d{4}", data[ i, 2 ] ) ).match )
        death_year::Integer = ( !is( data[ i, 4 ], NA ) ) ? parse( Int,( match( r"\d{4}", data[ i, 4 ] ) ).match ) : 0
        push!( all_presidents, President( birth_year, death_year ) )
    end

    isless( p1::President, p2::President ) = ( p1.birth_year < p2.birth_year )
    sort!( all_presidents, lt=isless )
    for i in 1:length( all_presidents )-1
        pivot::President = all_presidents[ i ]

        for j in i+1:length( all_presidents )
            if all_presidents[ j ].birth_year > pivot.death_year
                break
            else
                count += 1
            end
        end

        if count > time
            time = count
            index = i
        end

        count = 0
    end

    println( all_presidents[ index+time ].birth_year )
end

main( )
