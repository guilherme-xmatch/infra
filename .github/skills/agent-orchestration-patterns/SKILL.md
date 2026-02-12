---
name: agent-orchestration-patterns
description: "Padrões avançados para sistemas multi-agente: orquestração descentralizada, context isolation, roteamento em árvore, state machine formal, observabilidade e smart escalation."
---

# Agent Orchestration Patterns Skill

Use esta skill quando a tarefa envolver desenho, evolução ou correção de pipelines multi-agente.

## Objetivo

Garantir que o sistema opere com:
- Resiliência (sem SPOF real)
- Contexto mínimo entre agentes
- Paralelização segura
- Validação com decisão explícita
- Observabilidade fim a fim
- Controle de iterações e regressão

## Contrato de Handoff (Obrigatório)

```yaml
trace_id: string
span_id: string
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
  on_missing_artifact: BLOCKED
  on_timeout: PARTIAL
```

Regras:
- Não enviar histórico irrelevante.
- Não enviar chain-of-thought bruto.
- `max_context_chars <= 6000`.

## Árvore de Decisão de Validação

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

## State Machine Formal

Estados recomendados:
- INTAKE
- CONTEXT_LOAD
- PLANNING
- FIGMA_ANALYSIS (opcional)
- IMPLEMENTATION
- VALIDATION_PARALLEL
- DECISION_GATE
- REWORK
- SMART_ESCALATION
- APPROVED | BLOCKED | CANCELLED

Regras:
- Sem transição implícita.
- Toda transição registra evento com `trace_id`.

## Iteration Tracking + Regressão

Mínimos por iteração:
- `iteration_index`
- `critical_bugs`
- `medium_bugs`
- `test_pass_rate`
- `a11y_score`
- `duration_ms`

Trigger de regressão (exemplos):
- `critical_bugs` aumentou
- `test_pass_rate` caiu >= 5%
- `a11y_score` caiu >= 8%

## Prompting Estratificado (anti one-shot)

Use 4 camadas:
1. Briefing e restrições
2. Draft técnico
3. Crítica dirigida (risco/edge/security)
4. Refino + validação de schema

Se confiança < 0.8, repetir ciclo.

## Smart Escalation

Acionar quando:
- Orchestrator indisponível
- Timeout em validação
- Limite de iterações atingido
- Regressão crítica detectada

Ações:
- Eleger líder temporário
- Reduzir escopo para blockers
- Solicitar decisão humana quando risco crítico

## Checklist Operacional

- [ ] Handoff com contrato mínimo
- [ ] Trace propagado ponta a ponta
- [ ] Browser + Tech Lead rodando em paralelo quando possível
- [ ] Decision gate aplicado após validações
- [ ] Rework orientado por prioridade (critical > medium > low)
- [ ] Métricas de iteração persistidas
- [ ] Memória atualizada com padrões e antipadrões
