# Ansible Barman — Backup & Disaster Recovery para PostgreSQL 17

Projeto de automação Ansible para provisionamento e instrumentalização do **Barman (Backup and Recovery Manager)** em container Docker para a instância primária **PostgreSQL 17** (`tm_pg_17_edpostgres17`).

## Recursos e Configurações
- **Container Docker**: `tm_pg_barman` baseado em Debian 12 com Barman 3.20 e `postgresql-client-17`.
- **Modo de Backup**: WAL streaming contínuo + `pg_basebackup` (RPO = 0).
- **Retenção**: 3 backups completos (`retention_policy = REDUNDANCY 3`).
- **Agendamento Cron**: Diário às **14:00** (`0 14 * * *`) e manutenção contínua (`*/5 * * * *`).
- **Wrapper no Host**: `/usr/local/bin/barman` mapeando chamadas diretamente para o container.
- **Observabilidade**: Coletor Telegraf integrado ao InfluxDB e painel no Grafana com alertas críticos por e-mail.
