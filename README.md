# Projeto - Arquitetura de Computadores
Projeto da matéria Arquitetura de Computadores - FEI

Ínicio do projeto: 8/04/2025

**Introdução:**
    Neste projeto, será realizado, um simulador em um display para uma máquina de café. Ele possuirá opções onde o usuário possa realizar a escolha de seu café, que serão: o tipo de café (Espresso, café regular (coado), Cappuccino, Barista, Caffe Latte, Caffe Gelatto e etc). Assim como a quantidade próxima de café que a pessoa desejar, serão definidas como:
- Espresso (40ml);
- Lungo (110ml).

Cada tipo de café terá suas características, alguns terão leite e/ou gelo como opções. E a máquina não pode faltar água e café. Poderá ser implementado, nos displays, a quantidade restante de água, leite e café moído inseridos na máquina.

**Tabela dos cafés e seus respectivos ingredientes necessários ou não:**

| Tipo de café | Água | Café moído | Leite | Gelo |
| :---         |:---: | :---:      | :---: | ---: |
| Espresso     | ✔️   | ✔️        |       |      |
| Coado        | ✔️   | ✔️        |       |      |
| Cappuccino   | ✔️   | ✔️        |✔️    |      |
| Barista      | ✔️   | ✔️        |✔️    |      |
| Caffè Latte  | ✔️   | ✔️        |✔️    |      |
| Caffè Gelatto| ✔️   | ✔️        |✔️    |✔️    |


**Metodologia:**
    Será utilizado o simulador EdSim51, que foi empregado em todas as aulas de Arquitetura de Computadores, na linguagem Assembly.

**_Ideias iniciais - 8/04/2025:_**
    Em um conceito geral, vamos simular um seletor de tipos de café (onde serão os 6 tipos que foram mencionados anteriormente), o seletor de quantidade (Espresso 40ml ou Lungo 110ml), controle de ingredientes, exibição no display sobre a quantidade restante de água, café moído e leite, e impedir o preparo caso algum ingrediente necessário esteja em falta.


# Lista, primeiras implementações
1. Seleção do tipo de café e quantidade: usar switches de entrada para representar os botões de seleção, por exemplo: P1.0 a P1.2 para tipo de café. P1.3 para a quantidade.
2. Verificação de ingredientes: variáveis que armazenarão os níveis de ingredientes e cada vez que um café for preparado, subtrair as quantidades.
3. Displays de nível: ver sobre os displays do EdSim51 para mostrar os níveis de ingredientes.
4. Preparo: após o usuário ter selecionado o tipo de café (1.) e a máquina ter verificado os ingredientes (2.), simular o preparo onde um LED pode piscar ou acionar uma saída.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
**16/04/2025**
Possíveis próximas ideias à serem implementadas no projeto:
+ Mensagem de boas vindas;
+ Mostrar cada ingrediente em uma tela diferente do display (ao invés de todos juntos);
+ Reabastecer os ingredientes manualmente por botões;
+ Adicionar um pisca LED de alerta se o ingrediente acabar;
+ Adicionar um alerta visual ou talvez um som se faltar algo.


