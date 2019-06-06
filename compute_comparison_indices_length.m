function  comparisons = compute_comparison_indices_length( distances, dist, max_dist_diff )
    max_idx = length(distances);
    comparisons = zeros(1,max_idx);
    k=1;
    for idx=1:max_idx
        best_idx = -1;
        error = max_dist_diff;
        for i =idx:max_idx
            if abs(distances(i)-(distances(idx)+dist)) < error
                best_idx = i;
                error = abs(distances(i) - (distances(idx)+dist));
            end
        end
        if best_idx ~= -1
            comparisons(k)=best_idx;
            k=k+1;
        end
    end
    comparisons=comparisons(1,1:k-1);
end

