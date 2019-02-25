%Desenvolvido por Antônio Sousa - antonioaads@gmail.com

%Alterar os dados abaixo

    %Load do documento com a listagem dos itens
    in = load ('itens/KNAPDATA40.txt');

    pop_size        =   20;     %Tamanho da população
    cross_rate      =   0.6;    %Taxa de crossover dos indivíduos
    mutation_rate   =   0.90;   %Probabilidade de não mutação de um gene
    belong_percent  =   85;     %Porcentagem de preenchimento dos genes do individuo aleatorio
    max_iterations  =   1000;   %Número máximo de iterações
    max_constraint  =   15;     %Tamanho máximo suportado pela mochila

%Fim da parte de alteração de dados

%Chamada da função
final_population    = GA(pop_size, cross_rate, mutation_rate, belong_percent, max_iterations, max_constraint, in);
end_price           = final_population(1,1);
end_weight          = final_population(1,2);

disp("Valor inserido na mochila:");
disp(final_population(1,1));
disp("Peso utilizado:");
disp(final_population(1,2));
disp("Itens Escolhidos:");

for i=3:length(final_population)
    if final_population(1,i) == 1
        disp(i-2);
    end
end

clear belong_percent cross_rate final_population i in max_constraint max_iterations mutation_rate pop_size
