---
name: corrigir-bug
description: "Pipeline de debugging: diagnóstico → hipóteses → investigação → correção → validação → revisão"
agent: "1. Workflow Orchestrator"
tools:
  - read
  - edit
  - search
  - execute
  - agent
  - todo
  - web
  - thinking-patterns/*
  - shrimp-task-manager/*
  - atomic-memory-mcp/*
---

# Corrigir Bug Frontend

Investigue e corrija o bug seguindo o pipeline de debugging estruturado.

## Pipeline de Debugging (6 Etapas)

### 1. Diagnóstico Inicial
- Analisar o bug descrito. Reproduzir mentalmente os passos.
- Buscar contexto na memória (`atomic-memory-mcp`) — bugs similares, mudanças recentes.
- Classificar: bug funcional? visual? performance? regressão?

### 2. Investigação com Hipóteses
- Usar `thinking-patterns/debugging_approach` para decompor o problema.
- Listar no mínimo 3 hipóteses ordenadas por probabilidade.
- Para cada hipótese: evidência necessária + como testar.
- Usar `shrimp-task-manager` para rastrear as hipóteses.

### 3. Coleta de Evidências
- Ler código fonte das áreas suspeitas.
- Se possível, usar `4. Browser Validator` para inspecionar console/rede/DOM.
- Eliminar hipóteses sistematicamente (binary search debugging).

### 4. Correção Cirúrgica
- Usar `3. Frontend` para implementar a correção mínima e segura.
- Não "refatorar aproveitando" — resolver o bug com escopo mínimo.
- Adicionar guards/validações para prevenir recorrência.

### 5. Validação
- `4. Browser Validator`: confirmar que o bug foi resolvido.
- Testar cenário do bug + cenários adjacentes (regressão).
- Verificar que a correção não introduziu novos problemas.

### 6. Revisão e Aprendizado
- `5. Tech Lead Validator`: revisar a correção.
- Registrar na memória: causa root, solução, como prevenir.
- Se for bug recorrente → criar padrão de prevenção.

## Descrição do Bug

${input:bug:Descreva o bug em detalhes — o que acontece vs. o que era esperado, passos para reproduzir, frequência}

## URL/Arquivo Afetado

${input:local:URL da aplicação ou caminho do arquivo com o bug}

## Contexto adicional

${input:contexto:Quando começou? Houve mudança recente? Acontece sempre ou intermitente?}
