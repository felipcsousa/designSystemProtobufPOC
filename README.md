# 🚀 POC: Geração Automática de DTOs com Protobuf (Kotlin e Swift)

Este repositório demonstra a geração automatizada de DTOs (Data Transfer Objects) para Android (Kotlin) e iOS (Swift) a partir de um contrato definido em **Protobuf (.proto)**. Ao padronizar a definição do contrato em um arquivo `.proto`, é possível garantir a consistência entre diferentes plataformas, minimizando esforço manual e erros de sincronização.

## 🎯 Objetivo

- **Consistência entre plataformas**: Um único contrato `.proto` descreve a estrutura dos dados. A partir dele, geramos DTOs coerentes em Kotlin e Swift.
- **Redução de erros manuais**: Não é necessário escrever manualmente as classes de transporte. O processo automático garante que mudanças no contrato se refletirão imediatamente nos DTOs.
- **Integração no Design System**: Ao adotar esse processo, o time de tecnologia pode incorporar a geração de DTOs ao pipeline do Design System, assegurando que componentes em diferentes plataformas utilizem dados consistentes.

## 🛠️ Pré-Requisitos

Antes de executar o script de geração, verifique se você possui:

1. **Protoc (Protocol Buffers Compiler)**
   - No macOS via Homebrew:  
     ```bash
     brew install protobuf
     ```

   - Verifique a instalação:  
     ```bash
     protoc --version
     ```

   Deve retornar algo como `libprotoc 3.X.X`.

2. **Plugin Kotlin para Protobuf** (`protoc-gen-kotlin.jar`)
   - Baixe a versão desejada do [repositório oficial](https://github.com/protocolbuffers/protobuf-kotlin). Por exemplo:
     ```bash
     curl -Lo protoc-gen-kotlin.jar \
     https://repo1.maven.org/maven2/com/google/protobuf/protoc-gen-kotlin/1.3.0/protoc-gen-kotlin-1.3.0-jvm8.jar
     ```

   - Coloque este arquivo na raiz do projeto.

3. **Swift Protobuf** (para gerar o código Swift)
   - No macOS, por exemplo:
     ```bash
     brew install swift-protobuf
     ```

   Isso disponibiliza o `protoc-gen-swift` no seu PATH.

---

## 📂 Estrutura do Projeto

```bash
progress-indicator-poc/
├─ android/               # DTOs gerados em Kotlin serão colocados aqui após o script
├─ ios/                   # DTOs gerados em Swift serão colocados aqui após o script
├─ proto/
│  └─ progress_indicator.proto  # Definição do contrato Protobuf
├─ scripts/
│  └─ generate-dtos.sh    # Script para gerar os DTOs
├─ README.md
└─ generation.log          # Log do processo de geração (após rodar o script)
```
---
## 🔧 Como Rodar o Processo de Geração
-----------------------------------

1.  **Clone o repositório**:

    ```
    git clone https://github.com/seu-usuario/progress-indicator-poc.git
    cd progress-indicator-poc
    ```
    
2.  **Coloque o `protoc-gen-kotlin.jar` na raiz**:

    ```
    curl -Lo protoc-gen-kotlin.jar\
    https://repo1.maven.org/maven2/com/google/protobuf/protoc-gen-kotlin/1.3.0/protoc-gen-kotlin-1.3.0-jvm8.jar
    ```

3.  **Execute o script**:

    ```
    ./scripts/generate-dtos.sh
    ```

5.  **Verifique o resultado**:

    -   O diretório `android/` conterá os DTOs Kotlin correspondentes ao `.proto`.
    -   O diretório `ios/` conterá os DTOs Swift.

---

## 🤔 Sobre o Código Gerado

O código gerado para as plataformas Android (Kotlin) e iOS (Swift) possui as seguintes características:

-   **Orientação pela Ferramenta**:

    -   O código Kotlin e Swift é gerado pelo `protoc` e seus plugins. Isso garante que as estruturas sejam fiéis ao contrato definido no arquivo `.proto`.
    -   Não há customizações no código de geração. Tudo o que é definido no `.proto` é refletido automaticamente nos DTOs.
-   **Legibilidade vs. Padrão**:

    -   O código gerado pode parecer mais extenso e menos idiomático do que um DTO feito à mão. Isso ocorre porque o objetivo é garantir conformidade com o contrato Protobuf e o runtime do `SwiftProtobuf` e do `Kotlin Protobuf Extensions`.
    -   Os desenvolvedores raramente precisam editar o código gerado. Eles apenas interagem com as propriedades e métodos públicos disponibilizados pelas classes e structs geradas.

----------------------------------

## 💼 Benefícios para o Design System

-   **Manutenção Simplificada**:

    -   Uma alteração no arquivo `.proto` atualiza automaticamente todos os DTOs, eliminando a necessidade de manter versões manuais em iOS e Android.
    -   Isso garante consistência entre plataformas e reduz a chance de erros de comunicação entre diferentes times.
-   **Padronização de Dados**:

    -   Com o uso de Protobuf, o mesmo contrato de dados é aplicado para todas as plataformas (iOS, Android, ou qualquer outra que seja adicionada no futuro).
-   **Escalabilidade**:

    -   Com o processo estabelecido, adicionar novos campos ou criar novas mensagens de transporte é trivial. Basta alterar o `.proto`, rodar o script e todos os DTOs são atualizados.
    -   Isso permite escalar o Design System de forma rápida e eficiente.
-   **Redução de Débitos Técnicos**:

    -   Quando os DTOs são feitos manualmente, a equipe frequentemente esquece de atualizar todos os arquivos. Usar uma única fonte de verdade (o `.proto`) elimina esse risco.
