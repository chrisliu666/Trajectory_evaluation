function  re( p_es, q_es, p_gt, q_gt, T_cm, dist, max_dist_diff)
    scale=1.0 ;
    accum_distances = get_distance_from_start(p_gt);
    comparisons = compute_comparison_indices_length(accum_distances, dist, max_dist_diff);
    num=length(comparisons);
    T_mc = inv(T_cm);
    errors = cell(1,num);
    k=1;
    for idx=1:num
        if  comparisons(idx) ~= -1
            T_c1 = get_rigid_body_trafo(q_es(idx, :), p_es(idx, :));
            T_c2 = get_rigid_body_trafo(q_es(comparisons(idx), :), p_es(comparisons(idx), :));
            T_c1_c2 = inv(T_c1)*T_c2;
            T_c1_c2(1:3, 4) =  T_c1_c2(1:3, 4) *scale;

            T_m1 = get_rigid_body_trafo(q_gt(idx, :), p_gt(idx, :));
            T_m2 = get_rigid_body_trafo(q_gt(comparisons(idx), :), p_gt(comparisons(idx), :));
            T_m1_m2 = inv(T_m1)*T_m2;

            temp=T_m1_m2*T_mc;
            T_m1_m2_in_c1 = T_cm*temp;
            T_error_in_c2 = inv(T_m1_m2_in_c1)*T_c1_c2;
            T_c2_rot = eye(4);
            T_c2_rot(1:3, 1:3) = T_c2(1:3, 1:3);
            temp1= T_error_in_c2*inv(T_c2_rot);
            T_error_in_w = T_c2_rot*temp1;
            errors(k)=T_error_in_w;
            k=k+1;
        end
        errors=errors{1,1:k-1};
    end
    num=k-1;
    error_trans_norm = zeros(1,num);
    error_trans_perc =  zeros(1,num);
    error_yaw =zeros(1,num);
    error_gravity =zeros(1,num);x`
    e_rot = zeros(1,num);
    for j=1:num
        tn = norm(errors{j}(1:3, 4));
        error_trans_norm(j)=tn;
        error_trans_perc(j)= tn / dist * 100;
        ypr_angles =dcm2angle(errors{j});
        e_rot(j)=compute_angle(errors{j});
        error_yaw(j)=abs(ypr_angles(1))*180.0/pi;
        error_gravity(j)= sqrt(ypr_angles(2)^2+ypr_angles(3)^2)*180.0/pi;
end

