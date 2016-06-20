function res=transform_toNAN(pcl)
pcl(pcl==0)=NaN;
res = pcl;
end