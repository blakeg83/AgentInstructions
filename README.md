# AgentInstructions

Reusable, locally generated coding-agent instructions based on the engineering and Taiga workflows used in NostalGenius.

## Quick start

Clone this repository, then run the initializer against a project directory:

```powershell
pwsh ./scripts/Initialize-Project.ps1 -TargetPath ../MyApp -ProjectName MyApp -ProjectType dotnet -TaigaProject myapp
```

Or on Linux/macOS/WSL:

```bash
bash ./scripts/initialize-project.sh ../MyApp MyApp dotnet myapp
```

Supported project types: `dotnet` and `generic`. Omit the Taiga slug (or use `-` with Bash) to skip Taiga integration.

The initializer generates **local, editable** `AGENTS.md` and, when configured, `docs/taiga-agent-workflow.md`. The .NET profile adds engineering guidance to the common instructions. Templates are copied, not linked; generated projects have no runtime dependency on this repository.

**Safety:** Existing output files are never overwritten. Initialize a new project or manually merge desired changes. Commit generated files in the destination repository after review.

## Templates

- `templates/AGENTS.base.md`: universal engineering and agent workflow
- `templates/AGENTS.dotnet.md`: .NET-specific implementation standards
- `templates/taiga-agent-workflow.md`: reusable Taiga MCP guidance
- `templates/project-context.md`: optional project-specific context starter (copy and edit manually)

Source material: [NostalGenius AGENTS.md](https://github.com/blakeg83/nostalgenius/blob/main/AGENTS.md) and [Taiga workflow guide](https://github.com/blakeg83/nostalgenius/blob/main/docs/taiga-agent-workflow.md). Project-specific NostalGenius UI rules are intentionally excluded.

## Design

Taiga owns planning and work tracking; GitHub owns code, PRs, and durable technical documentation. Prefer KISS/YAGNI and reuse. Project-local instructions and the current user request take precedence over these shared defaults.
