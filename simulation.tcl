# Function to find minimum of two numbers
proc min {a b} {
    if {$a < $b} {
        return $a
    } else {
        return $b
    }
}

# Function to find maximum of two numbers
proc max {a b} {
    if {$a > $b} {
        return $a
    } else {
        return $b
    }
}

# Set simulation parameters
set num_bs 5           ;# Number of base stations
set num_users 20       ;# Number of users
set sim_time 1000      ;# Simulation time in seconds
set movement_interval 1;# Interval between user movements in seconds

# Initialize hand-off count
set handoff_count 0

# Define base stations and their coverage areas
for {set i 0} {$i < $num_bs} {incr i} {
    set bs($i) [list [expr {rand()*100}] [expr {rand()*100}]]
}

# Define users and their initial positions
for {set i 0} {$i < $num_users} {incr i} {
    set user($i) [list [expr {rand()*100}] [expr {rand()*100}]]
    set user_cur_bs($i) -1 ;# Current base station index (-1 for initial state)
}

# Create a file to store hand-off count over time
set output_file [open "handoff_count.dat" w]

# Simulate user movement and hand-off management
for {set t 0} {$t < $sim_time} {incr t $movement_interval} {
    # User movement simulation
    foreach user_id [array names user] {
        set x [lindex $user($user_id) 0]
        set y [lindex $user($user_id) 1]
        set dx [expr {rand()*2 - 1}]
        set dy [expr {rand()*2 - 1}]
        set x [expr {$x + $dx}]
        set y [expr {$y + $dy}]
        # Ensure users stay within the coverage area (0,100)
        set x [max 0 [min 100 $x]]
        set y [max 0 [min 100 $y]]
        set user($user_id) [list $x $y]
    }
    
   # Hand-off management based on OPI-RLI-HO scheme
    foreach user_id [array names user] {
        set user_pos $user($user_id)
        set nearest_bs -1
        set min_distance 99999
        
        # Find the nearest base station
        foreach bs_id [array names bs] {
            set bs_pos $bs($bs_id)
            set distance [expr {hypot([lindex $user_pos 0] - [lindex $bs_pos 0], [lindex $user_pos 1] - [lindex $bs_pos 1])}]
            if {$distance < $min_distance} {
                set min_distance $distance
                set nearest_bs $bs_id
            }
        }
        
        # Check if hand-off is necessary
        if {$nearest_bs != $user_cur_bs($user_id)} {
            # Hand-off is required
            incr handoff_count
            set user_cur_bs($user_id) $nearest_bs
            # Perform hand-off actions here (e.g., update user's connection)
        }
    }
    
    # Write hand-off count to output file
    puts $output_file "$t $handoff_count"
}

# Close the output file
close $output_file

# Print total number of hand-offs
puts "Total number of hand-offs: $handoff_count"


# Plot hand-off count over time using xgraph
exec xgraph -x "Time (s)" -y "Hand-off count" -tk -P handoff_count.dat &


# output: (would get differrnt Graphs as random values are being used 
# Total number of hand-offs: 257 (this would also be different for differrnt running times)
