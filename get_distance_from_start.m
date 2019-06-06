function Distances=get_distance_from_start( gt_translation )
    distances = diff(gt_translation(:, 1:3), 1);
    Distances = sqrt(sum(distances.^2, 2));
    Distances=cumsum(Distances,1);
    Distances=[0;Distances];
end

