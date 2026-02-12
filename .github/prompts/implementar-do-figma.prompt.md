---
name: implementar-do-figma
description: "Pipeline Figma-to-Code: análise de design → spec técnica → implementação frontend com memória e validação"
agent: "1. Workflow Orchestrator"
tools:
  - read
  - search
  - agent
  - todo
  - web
  - TalkToFigma/*
  - atomic-memory-mcp/*
  - shrimp-task-manager/*
---

# Implementar a partir do Figma

Analise o design no Figma e implemente o código frontend correspondente.

## Fluxo

1. **Contexto e Memória**: Consulte `atomic-memory-mcp` para design system existente, componentes já implementados e padrões.
2. **Análise Figma** (subagente `2. Figma Analyser`):
   - Conectar ao Figma via `TalkToFigma`.
   - Extrair hierarquia, tokens, estilos, estados e variantes.
   - Gerar especificação técnica orientada à implementação.
   - Identificar componentes reutilizáveis vs. novos.
3. **Implementação** (subagente `3. Frontend`):
   - Implementar baseado na spec gerada + convenções da memória.
   - Cobrir todos os estados (loading, erro, vazio, sucesso).
   - Acessibilidade, responsividade e tipagem completa.
4. **Validação paralela**:
   - `4. Browser Validator` — testar em 3 viewports + cenários de erro.
   - `5. Tech Lead Validator` — revisar qualidade, code smells, segurança.
5. **Loop de correção** se necessário.
6. **Memória**: registrar tokens, componentes e padrões novos.

## Referência do Figma

${input:figma_ref:URL do Figma, nome do frame ou descrição do componente a implementar}

## Contexto adicional

${input:contexto:Informações adicionais — existem componentes similares? Restrições técnicas? Padrões a seguir?}
