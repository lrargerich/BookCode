% GRADIENT DESCENT FOR MATRIX X INTO U*V DESCOMPOSITION
% By Luis Argerich
% THIS IS NOT STOCHASTIC GD!
% Algorithm from Rajaraman-Ullman-Leskovec Chapter 9
% PARAMETERS:
% X is the matrix with unknown values set to -100
% k = number of dimensions for latent model
% num_iters = number of iterations 

%X = [5 5 -100 5 2 1 1;5 -100 4 5 -100 2 3;3 1 2 -100 2 4 5;3 3 4 -100 2 -100 1;-100 3 4 1 5 5 -100;4 -100 3 4 2 -100 5]

function [opt_U,opt_V] = UVDdecomp(X,k,num_iters,tries)


U_accum = zeros(size(X,1),k);
V_accum = zeros(k,size(X,2));

figure(1);
clf;

RMSE_old = 999999999;

for pipi=1:tries,

U = rand(size(X,1),k);
V = rand(k,size(X,2));
RMSE_history = [];


for iters=1:num_iters,

% Update Matrix U
for r=1:size(U,1),
  for s=1:size(U,2),
	% Row r column s in U
	sumk =0;
	total = 0;
	cuad = 0;
	for j=1:size(X,2),
		sumk=0;
		for k=1:size(U,2),
			if (k~=s)
				sumk = sumk+(U(r,k)*V(k,j));
            end
        end
		if(X(r,j) > -100)
			total = total + (V(s,j) * (X(r,j)-sumk));
        end
		cuad = cuad + (V(s,j)^2);
    end
	total = total / cuad;
	U(r,s) = total; 
  end
end

% Update Matrix V
for r=1:size(V,1),
	for s=1:size(V,2),
		% row r column s in V
		sumk = 0;
		total = 0;
		cuad = 0;
		for i=1:size(X,1)
			sumk = 0;
			for k=1:size(U,2),
				if(k~=r)
					sumk = sumk + (U(i,k)*V(k,s));
                end
			end;
			if(X(i,s) > -100)
				total = total + (U(i,r) * (X(i,s)-sumk));
            end;
			cuad = cuad + (U(i,r)^2);
		end;
		total = total/cuad;
		V(r,s) = total;
	end;
end;

% Compute RMSE
P = U*V;
RMSE = 0;
for r=1:size(X,1)
	for s=1:size(X,2)
		if(X(r,s)>-100)
			RMSE = RMSE + ((X(r,s)-P(r,s))^2);
        end;
	end;
end;
RMSE_history = [RMSE_history;RMSE];

end;

RMSE
plot (RMSE_history)
hold on;

if (RMSE<RMSE_old),
	opt_U = U;
	opt_V = V;
	RMSE_old = RMSE;
end;

end
end




