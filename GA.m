function wp_population = GA(pop_size, cross_rate, mutation_rate, belong_percent, max_iterations, max_constraint, itens)
    number_itens = size(itens,1);
    INDIVIDUAL_SIZE = 1:number_itens;
    
    %Gerando a população inicial, de maneira randomica
    population = (randi(100,pop_size,length(INDIVIDUAL_SIZE))) > belong_percent;
   
    %Chamando a função fitness, retorna o preço já com punição
    [weight,price] = fitness(population, itens, max_constraint);
    
    %Ordena a popução em ordem dos melhores para os piores individuos
    wp_population = sortrows([(price') (weight') population], 1,'descend');
    
    %Pega apenas a parte da popução
    population = wp_population(:, (INDIVIDUAL_SIZE + 2));
    
  
    for it=1:max_iterations
        
        offspring_size = pop_size * cross_rate;
        offspring_pop = zeros([(pop_size - offspring_size) length(INDIVIDUAL_SIZE)]);
        
        for i=1:(pop_size - offspring_size)
            random_dad1 = randi(offspring_size);
            random_dad2 = randi(offspring_size);
            new_individual = crossover(population(random_dad1,:), population(random_dad2,:));
            
            offspring_pop(i,:) = mutation(new_individual, mutation_rate);
        end
        
        new_pop = zeros(pop_size, length(INDIVIDUAL_SIZE));
        new_pop(1:offspring_size,:) = population(1:offspring_size,:);
        new_pop((offspring_size + 1):pop_size, :) = offspring_pop(:,:);
        
         %Chamando a função fitness, retorna o preço já com punição
        [weight,price] = fitness(offspring_pop, itens, max_constraint);
        
        %Concatena os pais com os novos indivíduos
        parcial_population = [wp_population(1:offspring_size,:); [(price') (weight') offspring_pop]];
        
        %Ordena a popução em ordem dos melhores para os piores individuos
        wp_population = sortrows(parcial_population, 1,'descend');
        
        %Pega apenas a parte da popução
        population = wp_population(:, (INDIVIDUAL_SIZE + 2));
            
    end
end

%Função que chama a função que calcula o peso e o preço de cada invidividuo
%da população e aplica a devida punição
function [weight,price] = fitness(population, itens, max_constraint)
    %Chama a função que calcula o peso e o preço da mochila de cada ind.
    [weight, price_nopunishment] = BackpackWeight(population, itens);
    
    %Aplica punição para os indivíduos que ultrapassaram o peso max
    price = (weight<=max_constraint).*(price_nopunishment);
end

%Função que faz o crossover de dois indivíduos de maneira randomica
function offspring = crossover(individual_a,individual_b)
    individual_len = length(individual_a);
    cross_point = randi(individual_len);

    offspring = [individual_a(1:cross_point) individual_b(cross_point + 1:end)];
end

%Função que faz a mutação de um individuo de maneira randomica
function mutated = mutation(individual, mutation_rate) 
    prob = (rand(size(individual))) > mutation_rate;
    prob_inverse = prob == 0;
    
    individual_rand = (rand(size(individual))>0.5);
    
    mutated = (individual .* prob_inverse) + (individual_rand .* prob);
end