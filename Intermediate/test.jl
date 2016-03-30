type Interval
    start::Integer
    finish::Integer
end

function evaluate_interval( arr )
    sum = 0

    for i in 1:length( arr )
        if 1 < i < length( arr )
            if arr[ i ].start < arr[ i-1 ].finish   #   overlap with the previous
                if arr[ i ].start != arr[ i-1 ].start
                    sum -= arr[ i-1 ].finish - arr[ i ].start - 1
                    sum += arr[ i ].finish - arr[ i-1 ].finish
                else
                    sum -= arr[ i-1 ].finish - arr[ i-1 ].start - 1
                    sum += arr[ i ].finish - arr[ i-1 ].finish
                end
            end

        elseif 1 == i                               #   first interval
            sum += arr[ i ].finish - arr[ i ].start + 1

        else                                        #   last interval
            if arr[ i ].start > arr[ i-1 ].finish
                sum += arr[ i ].finish - arr[ i ].start + 1
            end
        end
    end

    return sum
end

n = x = y = sum = 0
n = parse( Int, chomp( readline( STDIN ) ) )
arr = Interval[]

println( "Reading input time:" )
@time while !eof( STDIN )
    ( x, y ) = sort( split( chomp( readline( STDIN ) ) ) )
    push!( arr, Interval( parse( Int, x ), parse( Int, y ) ) )
end

println( "Sorting intervals time:" )
isless( i1::Interval, i2::Interval ) = ( i1.start < i2.start )
@time sort!( lt=isless, arr )

println( "Evaluating intervals time:" )
@time sum = evaluate_interval( arr )
println( "Sum: ", sum )
