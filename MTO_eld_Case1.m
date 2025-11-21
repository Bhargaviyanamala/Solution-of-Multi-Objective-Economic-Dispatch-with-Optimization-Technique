% Run the MTOoptimizer with the Sphere Function
clc; 
clear;
Function_name='F1';
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);


% Parameters
seedNumber = dim; 
nVar = 10; 
VarMin = lb; 
VarMax = ub;
swarmSize = 50; 
maxItr = 500;
plotFitnessValue = true;
params = [0.5, 0.5, 0.5];  % [tempfac, deltafac, Deltafac]

% Objective function
objFunction = fobj;

% Run MTO Optimizer
    % MTOoptimizer - Mother Tree Optimization Algorithm
    % Inputs:
    % seedNumber: Seed for random number generation
    % objFunction: Objective function to minimize
    % nVar: Number of variables (dimensions)
    % VarMin, VarMax: Variable boundaries
    % swarmSize: Population size
    % maxItr: Maximum number of iterations
    % plotFitnessValue: Boolean to plot fitness over iterations
    % params: Parameters [tempfac, deltafac, Deltafac]
    
    rng(seedNumber);  % Set random seed for reproducibility
    p = nVar;  % Dimension of the problem
    T = swarmSize;  % Population size (must be even)
    KRS = maxItr;  % Maximum iterations
    tempfac = params(1); deltafac = params(2); Deltafac = params(3);
    
    % Initialize population within bounds
    lb = VarMin * ones(p, T); ub = VarMax * ones(p, T);
    P = lb + (ub - lb) .* rand(p, T);
    Nut = zeros(T, 1); 
    
    % Evaluate initial fitness
    for i = 1:T
        Nut(i) = objFunction(P(:, i));
    end
    
    MTp = T / 2 - 1;  % Mother tree connected population
    nff = MTp;  % First partially connected trees
    nfl = T - (MTp - 1);  % Last partially connected trees
    
    bestFitHistory = zeros(1, KRS);  % Track fitness over iterations
    
    % MTO Main Loop
    for krs = 1:KRS
        [B, I] = sort(Nut);  % Sort fitness and index
        P = P(:, I); Nut = Nut(I);
        bestFit = B(1); bestPos = P(:, 1);
        
        % TOP Mother Tree Exploration
        for c = 1:MTp/2
            delta = deltafac * (2 * round(rand(p, 1)) - 1) .* rand(p, 1);
            MotherTemp = P(:, 1) - delta;
            MotherFit = objFunction(MotherTemp);
            if MotherFit < Nut(1)
                P(:, 1) = MotherTemp;
                Nut(1) = MotherFit;
                for z = 1:MTp/2
                    Delta = Deltafac * (2 * round(rand(p, 1)) - 1) .* rand(p, 1);
                    MotherTemp = P(:, 1) - Delta;
                    MotherFit = objFunction(MotherTemp);
                    if MotherFit < Nut(1)
                        P(:, 1) = MotherTemp;
                        Nut(1) = MotherFit;
                    end
                end
            end
        end
        
        % First Partially Connected Trees
        for i = 2:nff
            temp = P(:, i); A = 0;
            for ii = 1:(i - 1)
                fac = i - ii + 1;
                A = A + (P(:, ii) - temp) / fac;
            end
            SubMotherTemp = temp + A;
            SubMotherFit = objFunction(SubMotherTemp);
            if SubMotherFit < Nut(i)
                P(:, i) = SubMotherTemp;
                Nut(i) = SubMotherFit;
            else
                P(:, i) = temp + tempfac * (2 * round(rand(p, 1)) - 1) .* rand(p, 1);
                Nut(i) = objFunction(P(:, i));
            end
        end
        
        % Fully Connected Trees
        for j = nff + 1:nfl
            temp = P(:, j); A = 0;
            for jj = j - MTp:j - 1
                fac = j - jj + 1;
                A = A + (P(:, jj) - temp) / fac;
            end
            P(:, j) = temp + A;
            Nut(j) = objFunction(P(:, j));
        end
        
        % Last Partially Connected Trees
        for k = nfl + 1:T
            temp = P(:, k); A = 0;
            for kk = k - MTp:T - MTp
                fac = k - kk + 1;
                A = A + (P(:, kk) - temp) / fac;
            end
            P(:, k) = temp + A;
            Nut(k) = objFunction(P(:, k));
        end
        
        % Store the best fitness value for each iteration
        bestFitHistory(krs) = bestFit;
        if plotFitnessValue
            plot(1:krs, bestFitHistory(1:krs), 'b', 'LineWidth', 1.5);
            xlabel('Iterations'); ylabel('Fitness Value'); grid on;
            title('MTO Fitness Evolution');
            pause(0.01);
        end
        
         % Display results every 50 iterations
        if round(maxItr/50)==maxItr/50,
       bestFit;
      bestPos;
        disp([  'Best_score=',num2str(bestFit)])
        end
        
        
        
        
    end
    
    % Output results
    outputFit = bestFit;
    outputPosition = bestPos;

bestFit=outputFit;
bestPos=outputPosition;
gBest=bestPos;


% Display results
fprintf('Best Fitness Value Found: %.6f\n', bestFit);
fprintf('Best Position Found:\n');


 %%%%%   Function_name='F2';
  if Function_name =='F1'
  
    [Fa Pg Pl  PT F2 ]=economicgeneration(gBest);
 %disp(sprintf( 'the emission cost is  %4.4f', F1))
 disp(sprintf( 'the fuel cost is  %4.4f', Fa))
 disp(sprintf( 'the emission cost is  %4.4f', F2))
 powergeneration= Pg
 powerloss=Pl
 %totalpowergeneratio=PT
  disp(sprintf( 'the  totalpowergeneration is  %4.4f', PT))
        
  end
   
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
 if Function_name =='F2'; 
     
[Fa Pg Pl  PT F2 ]=economicemission(gBest);
 %disp(sprintf( 'the emission cost is  %4.4f', F1))
 disp(sprintf( 'the emission cost is  %4.4f', Fa))
 disp(sprintf( 'the fuel cost is  %4.4f', F2))
 %
 powergeneration= Pg
 powerloss=Pl
disp(sprintf( 'the total powergeneration is  %4.4f', PT))
 end 
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
 if  Function_name =='F3'; 
     
[C Fa  Pg Pl  PT, F2]=economicemiandvalve(gBest);
  powergeneration= Pg
 powerloss=Pl
 %totalpowergeneration=PT

disp(sprintf( 'the combined cost is  %4.4f', C))
disp(sprintf( 'the emission cost is  %4.4f', Fa))
disp(sprintf( 'the fuel cost is  %4.4f', F2))
disp(sprintf( 'the totalpowergeneration is  %4.4f', PT))
 
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 if  Function_name =='F4'; 
     
[Pl  C Fa  Pg  PT F2]=economicloss(gBest);
 
 powerloss=Pl
 %totalpowergeneration=PT

disp(sprintf( 'the combined cost is  %4.4f', C))
disp(sprintf( 'the emission cost is  %4.4f', Fa))
 powergeneration= Pg
 disp(sprintf( 'the totalpowergeneration is  %4.4f', PT))
disp(sprintf( 'the fuel cost is  %4.4f', F2))

 
 end
 
 


