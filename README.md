# Steps to run the File

# ns simulation.tcl

OR

# xgraph -x "Time (s)" -y "Hand-off count" -tk -P handoff_count.dat

This code simulates a hand-off management system in a wireless communication network. Its functionality includes:

1. **Minimum and Maximum Functions**: Two procedures `min` and `max` are defined to find the minimum and maximum of two numbers respectively. These functions will be used later in the code to ensure that users stay within the coverage area of base stations.

2. **Simulation Parameters**: Several simulation parameters are set, including the number of base stations (`num_bs`), the number of users (`num_users`), simulation time in seconds (`sim_time`), and the interval between user movements in seconds (`movement_interval`).

3. **Hand-off Count Initialization**: `handoff_count` variable is initialized to keep track of the number of hand-offs that occur during the simulation.

4. **Base Station and User Initialization**:
   - Base stations (`bs`) are randomly positioned within the coverage area (0,100) using a loop.
   - Users (`user`) are also randomly positioned within the coverage area (0,100) and their initial base station indices (`user_cur_bs`) are set to -1.

5. **Output File Creation**: A file named "handoff_count.dat" is created to store the hand-off count over time.

6. **User Movement and Hand-off Management Simulation**:
   - A loop simulates user movement and hand-off management over time (`sim_time`).
   - Inside the loop, user movement is simulated by updating their positions randomly within a small range using a nested loop.
   - Hand-off management based on the OPI-RLI-HO (Optimization Parameter Interpolation-Received Level Indicator-Handover) scheme is performed for each user:
     - The nearest base station to each user is found by calculating the Euclidean distance between the user's position and each base station's position.
     - If the nearest base station is different from the user's current base station (`user_cur_bs`), a hand-off is considered necessary. The `handoff_count` is incremented, and the current base station index for the user is updated.
   - The current hand-off count at each simulation time step is written to the output file.

7. **Output File Closure**: The output file is closed after the simulation loop.

8. **Printing Total Hand-offs**: The total number of hand-offs is printed to the console.

9. **Plotting Hand-off Count Over Time**: Finally, the `xgraph` command is used to plot the hand-off count over time with the generated data file "handoff_count.dat". The x-axis represents time in seconds, and the y-axis represents the hand-off count.

In summary, this code simulates the movement of users in a wireless communication network and tracks the occurrence of hand-offs between base stations as users move around. It then outputs the total number of hand-offs and plots the hand-off count over time.
