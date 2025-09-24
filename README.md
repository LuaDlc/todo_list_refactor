# todo_list_refactor

A new Flutter project.

## Getting Started

📋 To-Do List Refatorado com Clean Architecture

Este é um aplicativo To-Do List desenvolvido em Flutter e refatorado para aplicar conceitos de Clean Architecture.
O projeto foi criado como prática para consolidar conhecimentos de arquitetura, boas práticas e testes automatizados.

🚀 Funcionalidades

Criar novas tarefas

Marcar/desmarcar como concluídas

Deletar tarefas individualmente ou limpar todas

🛠️ Ferramentas e Tecnologias

Flutter + Dart → desenvolvimento do app multiplataforma

BLoC (flutter_bloc) → gerenciamento de estado reativo com Eventos e Estados, permitindo uma UI desacoplada e previsível

SharedPreferences → armazenamento local simples, ideal para persistir listas pequenas sem a necessidade de banco de dados completo

GetIt → injeção de dependências, facilitando a manutenção do código e garantindo baixo acoplamento entre as camadas

Testes unitários (flutter_test + mockito) → asseguram a qualidade do código, mantendo legibilidade e facilidade de manutenção

📐 Arquitetura

O app segue os princípios da Clean Architecture, garantindo separação clara entre as camadas:

Domain → entidades e casos de uso (regras de negócio)

Data → models, data sources e repositórios

Presentation → blocos de estado e interface do usuário

Além disso, o código foi estruturado aplicando os princípios SOLID, reforçando boas práticas de desenvolvimento.

📚 Aprendizados

Com este projeto, pratiquei:

Uso de CRUD (Create, Read, Update, Delete) em Flutter

Aplicação de arquitetura limpa no ciclo completo do app

Criação e execução de testes unitários

Gerenciamento de estado com Bloc, entendendo seus padrões de eventos/estados

Injeção de dependências e desacoplamento usando GetIt
