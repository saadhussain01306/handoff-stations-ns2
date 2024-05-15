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
        lappend dataset [list "Traditional Handover" $rss $snr $cell_load $coverage_area $mobility_speed $handover_threshold]
    }
    return $dataset
}

# Function to generate dataset for Group Cell Handover (GCHO)
proc generate_gcho_dataset {num_samples} {
    set dataset {}
    for {set i 0} {$i < $num_samples} {incr i} {
        set group_size [expr {int([rand_range 2 5])}]
        set interference_level [rand_range 0 20]
        set group_load [rand_range 0 500]
        set group_coverage_area [rand_range 2 20]
        lappend dataset [list "Group Cell Handover" $group_size $interference_level $group_load $group_coverage_area]
    }
    return $dataset
}

# Function to generate dataset for OPI-RLI-HO method
proc generate_opi_rli_ho_dataset {num_samples} {
    set dataset {}
    for {set i 0} {$i < $num_samples} {incr i} {
        set optimization_parameter [rand_range 0 1]
        set received_level_indicator [rand_range 0 100]
        set handover_decision [expr {$received_level_indicator > 50 ? 1 : 0}]
        lappend dataset [list "OPI-RLI-HO" $optimization_parameter $received_level_indicator $handover_decision]
    }
    return $dataset
}

# Number of samples for each dataset
set num_samples 1000

# Generate datasets
set traditional_handover_dataset [generate_traditional_handover_dataset $num_samples]
set gcho_dataset [generate_gcho_dataset $num_samples]
set opi_rli_ho_dataset [generate_opi_rli_ho_dataset $num_samples]

# Combine datasets
set all_datasets [concat $traditional_handover_dataset $gcho_dataset $opi_rli_ho_dataset]

# Write combined dataset to CSV file
set file_handle [open "data_compare.csv" w]
puts $file_handle "Method,Received Signal Strength (RSS),Signal-to-Noise Ratio (SNR),Cell Load,Coverage Area,Mobility Speed,Handover Threshold,Group Size,Interference Level,Group Load,Group Coverage Area,Optimization Parameter,Received Level Indicator,Handover Decision"
foreach sample $all_datasets {
    puts $file_handle [join $sample ","]
}
close $file_handle

puts "Dataset saved to data_compare.csv"

