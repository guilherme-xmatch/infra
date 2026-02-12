---
name: orchestrator-autonomo
description: "Instruction canônico para execução autônoma do 1.Workflow Orchestrator com subtarefas, state machine explícita, decision routing e feedback obrigatório pós-Tech Lead"
agent: "1. Workflow Orchestrator"
tools:
  - read
  - search
  - agent
  - todo
  - web
---

# Instruction Canônico — Orchestrator Autônomo

Execute a tarefa de ponta a ponta sem pausas desnecessárias, coordenando tarefas e subtarefas com rastreabilidade, validação formal e feedback obrigatório.

## Objetivo Operacional

Garantir que o `1. Workflow Orchestrator`:
1. Planeje com granularidade de subtarefas.
2. Execute com handoff mínimo e contexto isolado.
3. Rode validações em paralelo quando possível.
4. Tome decisão por árvore de roteamento.
5. Chame obrigatoriamente `mcp-feedback-enhanced` após conclusão da etapa **Tech Lead** e novamente no encerramento consolidado.

## Regras de Autonomia (Obrigatórias)

1. Não interromper para pedir confirmação em etapas óbvias de execução.
2. Só bloquear quando faltar artefato crítico (`missing_artifact`) ou houver erro impeditivo.
3. Manter no máximo 1 subtarefa em `in-progress` por vez no controle de plano.
4. Reexecutar ciclo de correção quando houver finding crítico.
5. Toda conclusão de etapa deve registrar saída estruturada.
6. Aplicar limites de execução para evitar loops: `max_global_iterations=4`, `max_handoffs_per_cycle=12`, `max_turns_per_agent_call=8`.
7. Em rework, limpar contexto transitório de mensagens e preservar apenas artefatos de decisão.

## State Machine Formal

```yaml
states:
  - INTAKE
  - CONTEXT_LOAD
  - PLANNING
  - FIGMA_ANALYSIS
  - IMPLEMENTATION
  - VALIDATION_PARALLEL
  - DECISION_GATE
  - REWORK
  - SMART_ESCALATION
  - APPROVED
  - BLOCKED
  - CANCELLED
transitions:
  INTAKE: [CONTEXT_LOAD, BLOCKED]
  CONTEXT_LOAD: [PLANNING, BLOCKED]
  PLANNING: [FIGMA_ANALYSIS, IMPLEMENTATION, BLOCKED]
  FIGMA_ANALYSIS: [IMPLEMENTATION, BLOCKED]
  IMPLEMENTATION: [VALIDATION_PARALLEL, BLOCKED]
  VALIDATION_PARALLEL: [DECISION_GATE, SMART_ESCALATION, BLOCKED]
  DECISION_GATE: [APPROVED, REWORK, SMART_ESCALATION]
  REWORK: [IMPLEMENTATION, SMART_ESCALATION, BLOCKED]
  SMART_ESCALATION: [IMPLEMENTATION, BLOCKED, CANCELLED]
```

## Contrato de Handoff (Minimal Context)

```yaml
trace_id: string
task_id: string
objective: string
input_artifacts:
  - type: file|url|spec|diff
    ref: string
acceptance_criteria: string[]
constraints: string[]
output_schema:
  type: string
  required: string[]
error_handling:
  on_missing_artifact: "BLOCKED"
  on_timeout: "PARTIAL"
```

### Regra de Contexto
- Não enviar histórico completo quando o envelope for suficiente.
- Não enviar chain-of-thought bruto.
- Priorizar fatos + instrução acionável + schema de retorno.

## Fluxo Autônomo em Fases

### Fase 0 — Intake
**Entrada:** pedido do usuário + anexos.
**Saída:** classificação (`nova-tela`, `bug-fix`, `refatoracao`, `auditoria`) + `task_id` + `trace_id`.

### Fase 1 — Planejamento com Shrimp Task Manager
**Obrigatório:**
- Criar plano e decompor em subtarefas rastreáveis.
- Definir dependências e critérios de aceite por subtarefa.
- Executar em ordem de dependência.

**Checklist:**
- [ ] subtarefas claras
- [ ] critérios de aceite por subtarefa
- [ ] pontos de paralelização identificados

### Fase 2 — Execução de Workers
- Com Figma: `Figma Analyser -> Frontend -> (Browser || Tech Lead)`
- Sem Figma: `Frontend -> (Browser || Tech Lead)`

### Fase 3 — Decision Routing
Aplicar:
```yaml
if browser.critical_count > 0 or tech_lead.critical_count > 0:
  next: REWORK_FRONTEND
elif browser.medium_count > 0 or tech_lead.medium_count > 0:
  next: REWORK_OPTIONAL_GATE
elif timeout.any == true:
  next: SMART_ESCALATION
else:
  next: APPROVED
```

### Fase 3.1 — Durabilidade e Recuperação
- Salvar checkpoint ao concluir: `PLANNING`, `IMPLEMENTATION`, `VALIDATION_PARALLEL`, `DECISION_GATE`.
- Em falha/timeout, retomar do último checkpoint consistente.
- Emitir evento de recuperação com `trace_id` e estado de retorno.

### Fase 4 — Feedback Obrigatório (Regra Crítica)
1. **Imediatamente após concluir a etapa Tech Lead**, chamar `mcp-feedback-enhanced`.
2. Se houver rework e novo ciclo de Tech Lead, repetir chamada após cada conclusão de Tech Lead.
3. **Após consolidação final da tarefa (APPROVED/BLOCKED/CANCELLED)**, chamar `mcp-feedback-enhanced` novamente.

## Tratamento de Erros e Timeout

- `missing_artifact`: marcar subtarefa como `BLOCKED`, registrar itens faltantes e solicitar complemento objetivo.
- `timeout` em validação: retornar `PARTIAL`, acionar `SMART_ESCALATION` se impacto crítico.
- `iteration_limit_reached`: escalar com resumo dos blockers e trilha de tentativas.

## Critérios de Conclusão

A tarefa só é considerada concluída quando:
1. Todas as subtarefas dependentes estão `completed` ou `blocked` com justificativa.
2. Decision gate aplicado com veredito explícito.
3. Feedback pós-Tech Lead foi coletado.
4. Feedback de fechamento consolidado foi coletado.
5. Relatório final emitido.

## Formato de Relatório Final

```markdown
## DIAGNÓSTICO
- Tipo de tarefa:
- Objetivo:
- Riscos:

## PLANO E SUBTAREFAS
- [id] título — status — dependências

## EXECUÇÃO
- Etapas executadas:
- Handoffs realizados:
- Resultados de Browser e Tech Lead:

## DECISION GATE
- critical_count:
- medium_count:
- decisão:

## FEEDBACK (OBRIGATÓRIO)
- pós-Tech Lead: coletado? (sim/não)
- fechamento final: coletado? (sim/não)

## ESTADO FINAL
- APPROVED | REWORK | BLOCKED | CANCELLED
- próximos passos
```
