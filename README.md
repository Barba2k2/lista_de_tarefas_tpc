# Lista de Tarefas - Flutter

![Flutter Version](https://img.shields.io/badge/Flutter-3.29.3-blue)
![Dart Version](https://img.shields.io/badge/Dart-3.7.2-blue)

Um aplicativo de lista de tarefas moderno e intuitivo desenvolvido com Flutter, seguindo boas práticas de arquitetura e design. Este app permite gerenciar suas tarefas diárias com facilidade.

## 📋 Funcionalidades

- **Gerenciamento Completo de Tarefas**
  - ✅ Adicionar novas tarefas com nome e descrição
  - ✅ Visualizar lista de tarefas separadas por status (pendentes/concluídas)
  - ✅ Marcar tarefas como concluídas/pendentes
  - ✅ Editar detalhes de tarefas existentes
  - ✅ Remover tarefas com gesto de swipe
  - ✅ Persistência local de dados

- **Design Moderno**
  - ✅ Interface de usuário intuitiva e responsiva
  - ✅ Animações sutis para melhor experiência
  - ✅ Feedback visual para todas as ações
  - ✅ Temas e cores personalizados
  - ✅ Suporte para diferentes tamanhos de tela

## 🏗️ Arquitetura

Este projeto segue o padrão de arquitetura MVVM (Model-View-ViewModel) com uma estrutura de camadas inspirada em Clean Architecture, proporcionando:

- **Separação de Responsabilidades**: Código organizado e fácil de manter
- **Testabilidade**: Componentes desacoplados facilitam a escrita de testes
- **Escalabilidade**: Facilidade para adicionar novos recursos
- **Manutenibilidade**: Estrutura clara facilita o entendimento do código

### Camadas:

```
lib/
├── config/         # Configurações globais da aplicação
│   └── theme/      # Sistema de temas (cores, textos, dimensões)
├── data/           # Camada de dados
│   ├── repository/ # Implementações de repositórios
│   └── services/   # Serviços para persistência e API
├── domain/         # Regras de negócio
│   ├── models/     # Modelos de dados
│   └── use_cases/  # Casos de uso da aplicação
├── ui/             # Interface do usuário
│   ├── common/     # Widgets comuns reutilizáveis
│   ├── todo/       # Tela de lista de tarefas
│   └── todo_details/ # Tela de detalhes da tarefa
└── utils/          # Utilitários e helpers
```

## 🛠️ Tecnologias

- **Flutter**: Framework UI para desenvolvimento cross-platform
- **Dart**: Linguagem de programação
- **Provider**: Injeção de dependências
- **ChangeNotifier**: Padrão de gerenciamento de estado
- **SharedPreferences**: Persistência local de dados
- **GoRouter**: Navegação entre telas
- **Google Fonts**: Tipografia

## 🔧 Requisitos e Configuração do Ambiente

### Versão do Flutter

Este projeto foi desenvolvido e testado com Flutter:

```
Flutter 3.29.3 • channel stable
Dart 3.3.1 • DevTools 2.31.1
```

### Configuração do Ambiente

#### Opção 1: Atualizar para a versão recomendada

Para garantir compatibilidade, atualize seu Flutter para a versão recomendada:

```bash
flutter upgrade
flutter --version  # Verifique se a versão atual é 3.29.3
```

#### Opção 2: Usar o Flutter Version Manager (FVM)

Para quem trabalha com múltiplos projetos Flutter, recomendamos usar o FVM:

1. Instale o FVM:
   ```bash
   dart pub global activate fvm
   ```

2. Configure a versão para este projeto:
   ```bash
   fvm install 3.29.3
   fvm use 3.29.3
   ```

3. Execute comandos Flutter usando FVM:
   ```bash
   fvm flutter pub get
   fvm flutter run
   ```

## 🚀 Instalação

1. Certifique-se de ter o Flutter instalado em sua máquina. Para instalar, siga as [instruções oficiais](https://flutter.dev/docs/get-started/install).

2. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/lista-de-tarefas.git
   ```

3. Navegue até o diretório do projeto:
   ```bash
   cd lista-de-tarefas
   ```

4. Instale as dependências:
   ```bash
   flutter pub get
   ```

5. Execute o aplicativo:
   ```bash
   flutter run
   ```

## 💡 Decisões de Implementação

### Gerenciamento de Estado
Escolhi o **Provider** como solução de gerenciamento de estado por sua simplicidade, eficiência e integração nativa com o Flutter. Ele permite a separação clara entre a lógica de negócios e a interface do usuário, seguindo o padrão MVVM.

### Persistência de Dados
A persistência local é implementada usando **SharedPreferences**, permitindo que as tarefas sejam salvas entre sessões da aplicação. Esta abordagem é eficiente para a quantidade de dados gerenciada pelo aplicativo.

### Componentização
Criei componentes reutilizáveis para toda a UI, mantendo o código DRY (Don't Repeat Yourself) e garantindo consistência visual em todo o aplicativo:

- `AppLoadingWidget`: Indicadores de carregamento padronizados
- `AppErrorWidget`: Exibição uniforme de erros
- `AppStatusBadge`: Badge para status de tarefas
- `AppActionButton`: Botões de ação com estados de carregamento
- `AppAnimatedContainer`: Encapsula animações reutilizáveis

### Estilização
Implementei um sistema de temas abrangente para garantir consistência visual e facilitar mudanças futuras:

- `AppColors`: Paleta de cores centralizada
- `AppTextStyles`: Estilos de texto baseados no Google Fonts
- `AppDimensions`: Dimensões e espaçamentos responsivos

## 📱 Uso

### Adicionar uma Nova Tarefa
1. Toque no botão flutuante "+ Nova Tarefa"
2. Preencha o nome e a descrição da tarefa
3. Toque em "Adicionar"

### Gerenciar Tarefas
- **Concluir uma tarefa**: Toque no checkbox ao lado do nome da tarefa
- **Ver detalhes**: Toque na tarefa para ver mais informações
- **Excluir uma tarefa**: Aperte na lixeira ao lado direito da tarefa
- **Editar uma tarefa**: Abra os detalhes da tarefa e toque no botão de edição