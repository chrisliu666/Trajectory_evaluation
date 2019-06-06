function angle = compute_angle( transform )
angle= arccos( min(1, max(-1, (trace(transform(1:3, 1:3)) - 1)/2)))*180.0/pi;
end

