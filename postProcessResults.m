%% this script runs at the end of every simulink run


% plot a 3D trajectory
trajectory_reconstruction(results_state)

%plot state
state_plot(results_state,results_Vinf,results_force,results_moments)