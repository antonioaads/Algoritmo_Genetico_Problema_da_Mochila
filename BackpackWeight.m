function [weight, price] = BackpackWeight(population, itens)

    %Montagem de um vetor com os valores dos pesos e preços dos itens que
    %foram escolhidos
    parcial_weight  = population .* itens(:,2)';
    parcial_price   = population .* itens(:,3)';
    
    %Soma dos pesos e dos preços dos itens escolhidos
    weight  = sum((parcial_weight'));
    price   = sum((parcial_price'));
end