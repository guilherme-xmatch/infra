---
name: refatoracao-profunda
description: "Pipeline de refatoração profunda: análise → planejamento → execução incremental → validação → revisão — com preservação de comportamento"
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
  - minidoracat-mcp-feedback-enhanced/*
---

# Refatoração Profunda

Execute uma refatoração estruturada com preservação de comportamento e validação completa.

## Pipeline de Refatoração (6 Fases)

### Fase 1 — Análise e Escopo
- Mapear o código atual: estrutura, dependências, acoplamentos.
- Consultar memória (`atomic-memory-mcp`) para decisões anteriores e padrões.
- Identificar code smells existentes (Long Method, God Component, Duplicate Code, etc.).
- Definir escopo claro: o que refatorar, o que NÃO tocar.
- Usar `thinking-patterns` para análise de impacto.

### Fase 2 — Planejamento Incremental
- Decompor em **etapas atômicas** — cada uma deve preservar comportamento.
- Ordem de execução: dependências primeiro, consumidores depois.
- Criar tasks no `shrimp-task-manager` com critérios de aceite.

### Fase 3 — Execução Incremental
- Usar `3. Frontend` para implementar cada etapa.
- **Regra de ouro**: após cada mudança, o código deve funcionar normalmente.
- Não misturar refatoração com features novas.

### Fase 4 — Validação
- `4. Browser Validator`: confirmar que nada quebrou.
- Testar fluxos principais + cenários de edge case.
- Comparar comportamento antes vs. depois.

### Fase 5 — Revisão
- `5. Tech Lead Validator`: avaliar se a refatoração melhorou qualidade.
- Verificar: code smells eliminados? Novos padrões consistentes?

### Fase 6 — Consolidação
- Registrar padrões consolidados na memória.
- Documentar decisões de refatoração.
- Feedback do usuário via `minidoracat-mcp-feedback-enhanced`.

## Alvo da Refatoração

${input:alvo:Descreva o que precisa ser refatorado — arquivo, componente, módulo, padrão}

## Motivação

${input:motivacao:Por que refatorar? Code smell, performance, legibilidade, preparação para feature nova?}

## Constraints

${input:constraints:Restrições — o que NÃO pode mudar? Comportamentos que devem ser preservados?}
