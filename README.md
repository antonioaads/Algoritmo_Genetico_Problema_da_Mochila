# Algorítmo Genético para o Problema da Mochila

Esse repositório possui um algorítmo genético implementado para solução do problema da mochila. Foi feito para introdução e melhor entendimento do algoritmo e de seu funcionamento. 

## O problema da mochila

O problema da mochila solucionado nesse repositório, trata-se do seguinte: Existem n itens, que possuem um peso e um valor específico, que devem ser inseridos em uma "mochila" que possui um peso máximo x.

O objetivo é escolher itens que resulte no maior valor agregado na mochila, sem ultrapassar o peso máximo suportado por ela.

## Implementação

### Inserção dos itens

Antes de rodar o algoritmo, necessita-se de ter um banco de dados que liste os itens que podem ser escolhidos para serem inseridos na mochila. Esses exemplos estão dentro da pasta itens. 

O padrão de como esses itens são listados é de extrema importância, e devem seguir o seguinte padrão: Três colunas separadas por espaço, sendo cada linha representada por um item, com a primeira coluna sendo a ordem do item, numero de 1 até o número máximo de itens, a segunda o peso do item, e a terceira o valor do item. 

Um modelo válido, com 20 itens, pode ser observado abaixo:

![Modelo de Entrada](img/in_model.png)

No início da main possui uma linha de load, que busca o itens para o workspace do MATLAB. Caso queira usar um exemplo próprio, basta colocar o nome do seu documento na linha do load, conforme abaixo:

    in = load ('itens/nome_do_seu_documento.txt');

