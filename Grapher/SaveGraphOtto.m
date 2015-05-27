function SaveGraphOtto(graph,labels,name)
[r,c]   = find(graph~=0);
v       = nonzeros(graph);
compact = [r,c,v];
filename = sprintf('%s_edges.csv',name);
fid = fopen(filename, 'w');
fprintf(fid, 'Source,Target,Weight\n');
fclose(fid);
dlmwrite(filename, compact, '-append', 'precision', '%.6f', 'delimiter', ',');
%Write node list and labels
node_list=labels;
filename = sprintf('%s_nodes.csv',name);
fid = fopen(filename, 'w');
fprintf(fid, 'Id,numnodes,lensavg,labelavg\n');
fclose(fid);
dlmwrite(filename, node_list, '-append', 'precision', '%.6f', 'delimiter', ',');
end