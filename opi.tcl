# Function to generate random values within a range
proc rand_range {min max} {
    return [expr {rand() * ($max - $min) + $min}]
}

# Function to generate dataset for OPI-RLI-HO method
proc generate_opi_rli_ho_dataset {num_samples} {
    set dataset {}
    for {set i 0} {$i < $num_samples} {incr i} {
        set optimization_parameter [rand_range 0 1]
        set received_level_indicator [rand_range 0 100]
        set handover_decision [expr {$received_level_indicator > 50 ? 1 : 0}]
        lappend dataset [list $optimization_parameter $received_level_indicator $handover_decision]
    }
    return $dataset
}

# Number of samples for the dataset
set num_samples 1000

# Generate dataset
set opi_rli_ho_dataset [generate_opi_rli_ho_dataset $num_samples]

# Write dataset to CSV file
set file_handle [open "data_opi.csv" w]
puts $file_handle "Optimization Parameter,Received Level Indicator,Handover Decision"
foreach sample $opi_rli_ho_dataset {
    puts $file_handle [join $sample ","]
}
close $file_handle

puts "Dataset saved to data_opi.csv"

