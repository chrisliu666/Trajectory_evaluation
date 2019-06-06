function ate(p_es,q_es,p_gt,q_gt)
    e_trans_vec = (p_gt-p_es);
    e_trans =sqrt(sum(e_trans_vec.^2, 2));
    
    %orientation error
    num=length(e_trans)
    e_rot=zeros(1,num);
    [n,m]=size(p_es);
    e_ypl = zeros(n,m);
    
    q_ess(:,1)=q_es(:,4);
    q_ess(:,2)=q_es(:,1);
    q_ess(:,3)=q_es(:,2);
    q_ess(:,4)=q_es(:,3);
    
    q_gts(:,1)=q_gt(:,4);
    q_gts(:,2)=q_gt(:,1);
    q_gts(:,3)=q_gt(:,2);
    q_gts(:,4)=q_gt(:,3);
    for i=1:num
        R_we=quat2dcm(q_ess(i,:));
        R_wg=quat2dcm(q_gts(i,:));
        e_R=R_we*inv(R_wg);
        e_ypl=dcm2angle(e_R);
        e_rot(i)=norm(logmap_so3(e_R));
    end
    
    motion_gt = diff(p_gt);
    motion_es =diff(p_es);
    dist_gt = sqrt(sum(motion_gt.^2, 2));
    dist_es = sqrt(sum(motion_es.^2, 2));
    e_scale_perc = dist_es./dist_gt-1.0;
    
   
end
