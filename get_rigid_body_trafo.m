function T= get_rigid_body_trafo( quat, trans )
    T = quat2dcm(quat);
    T(1:3, 4) = trans;
    T=[T;[0 0 0 1]];
    
end

