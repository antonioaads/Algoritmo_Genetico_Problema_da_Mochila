function population_ordered = GA(pop_size, cross_rate, mutation_rate, belong_percent, max_iterations, max_constraint, itens)
    number_itens = size(itens,1);
    INDIVIDUAL_SIZE = 1:number_itens;
    
    %Gerando a população inicial, de maneira randomica
    population = (randi(100,pop_size,length(INDIVIDUAL_SIZE))) > belong_percent;
    disp(population)
   
    %Chamando a função fitness, retorna o preço já com punição
    [weight,price] = fitness(population, itens, max_constraint);
    
    %Ordena a popução em ordem dos melhores para os piores individuos
    wp_population = sortrows([(price') (weight') population], 1,'descend');
    
    %Pega apenas a parte da popução
    population_ordered = wp_population(:, (INDIVIDUAL_SIZE + 2))
    
  
    for it=1:max_iterations
        
        offspring_size = pop_size * cross_rate;
        offspring_pop = zeros([(pop_size - offspring_size) length(INDIVIDUAL_SIZE)]);
        
        for i=1:(pop_size - offspring_size)
            mate1 = randi(offspring_size);
            mate2 = randi(offspring_size);
            new_mate = crossover(population(mate1,:), population(mate2,:));
            
            offspring_pop(i,:) = mutation(new_mate, mutation_rate, lower_bound, upper_bound);
        end
        
        new_pop_size = 2 * offspring_size;
        new_pop = zeros(new_pop_size, length(INDIVIDUAL_SIZE));
        new_pop(1:offspring_size,:) = population(1:offspring_size,:);
        new_pop((offspring_size + 1):new_pop_size, :) = offspring_pop(1:offspring_size,:);
        
        fit_offspring = fitness(offspring_pop, max_constraint);
        fit = [fit(1:offspring_size,:);fit_offspring];
        
        new_pop = sortrows([fit new_pop], 1, 'descend');
        
        fit = new_pop(1:pop_size,1);
        population = new_pop(1:pop_size, (INDIVIDUAL_SIZE + 1));
        
        melhores(it) = fit(1);
    end
    %}
end

function [weight,price] = fitness(population, itens, max_constraint)
    %Chama a função que calcula o peso e o preço da mochila de cada ind.
    [weight, price_nopunishment] = BackpackWeight(population, itens);
    
    %Aplica punição para os indivíduos que ultrapassaram o peso max
    price = (weight<=max_constraint).*(price_nopunishment);
end

function [mtow, constraint] = calcFit(individual) 
    try
        [mtow, constraint] = Biplano_MDO_2019ULTRACABULOSO(individual);
    catch ex
        mtow = 0;
        constraint = 0;
    end
end

function offspring = crossover(a,b)
    ind_len = length(a);
    cross_point = randi(ind_len);

    offspring = [a(1:cross_point) b(cross_point + 1:end)];
end

function mutated = mutation(individual, mutation_rate, lower_bound, upper_bound) 
    prob = (rand(size(individual))) > mutation_rate;
    prob_inverse = prob == 0;
    
    individual_rand = rand(size(individual)) .* (upper_bound - lower_bound) + lower_bound;
    
    mutated = (individual .* prob_inverse) + (individual_rand .* prob);
end