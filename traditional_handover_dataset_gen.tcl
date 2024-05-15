# Function to generate random values within a range
proc rand_range {min max} {
    return [expr {rand() * ($max - $min) + $min}]
}

# Function to generate dataset for Traditional Handover
proc generate_traditional_handover_dataset {num_samples} {
    set dataset {}
    for {set i 0} {$i < $num_samples} {incr i} {
        set rss [rand_range 0 -120]
        set snr [rand_range 0 30]
        set cell_load [rand_range 0 100]
        set coverage_area [rand_range 1 10]
        set mobility_speed [rand_range 0 120]
        set handover_threshold [rand_range -90 -110]
        lappend dataset [list $rss $snr $cell_load $coverage_area $mobility_speed $handover_threshold]
    }
    return $dataset
}

# Number of samples for the dataset
set num_samples 1000

# Generate dataset
set traditional_handover_dataset [generate_traditional_handover_dataset $num_samples]

# Write dataset to CSV file
set file_handle [open "data_trad.csv" w]
puts $file_handle "Received Signal Strength (RSS),Signal-to-Noise Ratio (SNR),Cell Load,Cell Coverage Area,Mobility Speed,Handover Threshold"
foreach sample $traditional_handover_dataset {
    puts $file_handle [join $sample ","]
}
close $file_handle

puts "Dataset saved to data_trad.csv"

