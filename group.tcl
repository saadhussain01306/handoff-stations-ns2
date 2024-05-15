# Function to generate random values within a range
proc rand_range {min max} {
    return [expr {rand() * ($max - $min) + $min}]
}

# Function to generate dataset for Group Cell Handover (GCHO)
proc generate_gcho_dataset {num_samples} {
    set dataset {}
    for {set i 0} {$i < $num_samples} {incr i} {
        set group_size [expr {int([rand_range 2 5])}]
        set interference_level [rand_range 0 20]
        set group_load [rand_range 0 500]
        set group_coverage_area [rand_range 2 20]
        lappend dataset [list $group_size $interference_level $group_load $group_coverage_area]
    }
    return $dataset
}

# Number of samples for the dataset
set num_samples 1000

# Generate dataset
set gcho_dataset [generate_gcho_dataset $num_samples]

# Write dataset to CSV file
set file_handle [open "data_group.csv" w]
puts $file_handle "Group Size,Interference Level,Group Load,Group Coverage Area"
foreach sample $gcho_dataset {
    puts $file_handle [join $sample ","]
}
close $file_handle

puts "Dataset saved to data_group.csv"

