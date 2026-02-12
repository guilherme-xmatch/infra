---
name: pipeline-completo
description: "Pipeline completo de desenvolvimento: Diagnóstico → Planejamento → Figma → Frontend → Browser → Tech Lead → Consolidação"
agent: "1. Workflow Orchestrator"
tools:
  - read
  - search
  - agent
  - todo
  - web
---

# Pipeline Completo de Desenvolvimento Frontend

Execute o pipeline completo de desenvolvimento para a tarefa descrita abaixo, seguindo rigorosamente o fluxo avançado do Workflow Orchestrator.

## Fluxo Obrigatório (6 Fases)

### Fase 0 — Diagnóstico e Memória
1. Leia o pedido e resuma em 2-3 frases o que deve ser alcançado.
2. Busque contexto na memória (`atomic-memory-mcp`) — convenções, padrões, decisões anteriores.
3. Liste suposições e pergunte o que falta.
4. Classifique: envolve Figma? Qual tipo de tarefa?

### Fase 1 — Planejamento Estruturado
1. Use `thinking-patterns` para decompor (collaborative_reasoning ou process_thought).
2. Use `shrimp-task-manager` para criar subtarefas com dependências.
3. Identifique o que pode rodar em **paralelo** (Browser + Tech Lead).
4. Apresente o plano ao usuário ANTES de executar.

### Fase 2 — Execução por Agentes
**Se envolver Figma:**
1. `2. Figma Analyser` → Inspecionar design → Gerar spec técnica
2. `3. Frontend` → Implementar código baseado na spec + memória
3. Em **paralelo**: `4. Browser Validator` + `5. Tech Lead Validator`
4. **Assim que Tech Lead concluir**, chamar `mcp-feedback-enhanced` obrigatoriamente.
5. Se houver problemas → loop de correção com `3. Frontend`
6. Se houver novo ciclo de Tech Lead, repetir a coleta de feedback após cada conclusão.

**Se NÃO envolver Figma:**
1. `3. Frontend` → Implementar a partir do plano + memória
2. Em **paralelo**: `4. Browser Validator` + `5. Tech Lead Validator`
3. **Assim que Tech Lead concluir**, chamar `mcp-feedback-enhanced` obrigatoriamente.
4. Loop de correção se necessário
5. Se houver novo ciclo de Tech Lead, repetir a coleta de feedback após cada conclusão.

### Fase 3 — Controles de Qualidade
- Consolidar relatórios de Browser Validator e Tech Lead Validator.
- Verificar: code smells corrigidos? Segurança ok? Acessibilidade ok?
- Se REPROVADO em qualquer validação → re-acionar Frontend.

### Fase 4 — Consolidação
- Integrar resultados finais.
- Atualizar memória (`atomic-memory-mcp`) com decisões e padrões.
- Gerar relatório final com entregas, pendências e próximos passos.

### Fase 5 — Feedback do Usuário
- Usar `mcp-feedback-enhanced` para coletar feedback final consolidado.
- Iterar se necessário baseado no feedback.

## Regra Crítica de Feedback (Não Opcional)

1. Deve existir feedback obrigatório após **cada conclusão de etapa Tech Lead**.
2. Deve existir feedback obrigatório no **encerramento consolidado** da tarefa.
3. Se ocorrer timeout na coleta, registrar `feedback_status=timeout` e acionar estado seguro (`SMART_ESCALATION` ou `BLOCKED`, conforme impacto).
4. Não concluir o pipeline sem registrar os dois pontos de feedback.

## Estratégia de Modelos
- **Orchestrator**: modelo de raciocínio (planejamento, decisões complexas)
- **Frontend**: modelo rápido (edições de código, iterações)
- **Tech Lead**: modelo de raciocínio (avaliação crítica)

## Tarefa

${input:tarefa:Descreva a tarefa de desenvolvimento frontend em detalhes — objetivo, contexto, constraints}
