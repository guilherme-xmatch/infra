# Pre-tool guard: protege contra operações perigosas
# e faz log de todas as invocações de ferramentas

$ErrorActionPreference = "Stop"

try {
    $input = [Console]::In.ReadToEnd() | ConvertFrom-Json
    $toolName = $input.toolName
    $toolArgs = $input.toolArgs
    $timestamp = Get-Date -Format "o"

    # Log da invocação
    $logDir = Join-Path $PSScriptRoot ".." "logs"
    if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir -Force | Out-Null }
    
    Add-Content -Path (Join-Path $logDir "tools.log") -Value "$timestamp | PRE_TOOL | tool=$toolName"

    # Bloquear comandos destrutivos perigosos
    if ($toolName -eq "bash" -or $toolName -eq "execute") {
        $parsedArgs = $toolArgs | ConvertFrom-Json -ErrorAction SilentlyContinue
        $command = $parsedArgs.command

        if ($command -match "rm -rf /|format [A-Z]:|DROP TABLE|DROP DATABASE|sudo rm|mkfs") {
            $output = @{
                permissionDecision = "deny"
                permissionDecisionReason = "Comando potencialmente destrutivo detectado. Operação bloqueada por segurança."
            }
            $output | ConvertTo-Json -Compress
            Add-Content -Path (Join-Path $logDir "blocked.log") -Value "$timestamp | BLOCKED | tool=$toolName | command=$command"
            exit 0
        }
    }

    # Bloquear edição de arquivos de configuração críticos
    if ($toolName -eq "edit" -or $toolName -eq "create") {
        $parsedArgs = $toolArgs | ConvertFrom-Json -ErrorAction SilentlyContinue
        $filePath = if ($parsedArgs.path) { $parsedArgs.path } elseif ($parsedArgs.filePath) { $parsedArgs.filePath } else { "" }

        if ($filePath -match "\.env$|\.env\.local$|\.env\.production$|package-lock\.json$|yarn\.lock$") {
            $output = @{
                permissionDecision = "deny"
                permissionDecisionReason = "Arquivo sensível detectado ($filePath). Edição manual recomendada."
            }
            $output | ConvertTo-Json -Compress
            Add-Content -Path (Join-Path $logDir "blocked.log") -Value "$timestamp | BLOCKED | tool=$toolName | file=$filePath"
            exit 0
        }
    }

    # Permitir por padrão
    exit 0
} catch {
    Write-Error $_.Exception.Message
    exit 1
}
