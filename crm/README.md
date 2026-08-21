# Open Estimate CRM Workflow

Functional CRM prototype built from the five design artboards in `crmdesignsource.zip`.

## URL

When deployed through the existing GitHub Pages repository:

`https://jamesehigh.github.io/franchise-job-status-hub/crm/`

The original hub at `/franchise-job-status-hub/` remains unchanged.

## Working features

- Microsoft 365 sign-in experience placeholder and role switching
- Real job dataset from the parent hub
- Role-scoped pipeline, filters, KPIs, sorting, pagination, CSV export, and JSON snapshot
- Age-based coaching prompts
- Next-step owner, due date, priority, state, support request, and shared read status
- My Day queue with overdue, due today, upcoming, and completed lanes
- CRM object decision screen
- Notification preview and per-user prototype preferences
- Permission matrix and production integration checklist
- Browser-local prototype storage for safe public demonstration

## Enable shared CRM tasks

`supabase-crm-setup.sql` defines the proposed shared task table for the CRM integration owner. The public prototype intentionally does not embed database credentials; task changes remain in browser local storage until an authenticated integration is connected.

The SQL mirrors the current hub's open-link policy only for prototype continuity. Replace it with authenticated policies before production.

## Production boundaries

The following require CRM and Microsoft 365 configuration outside this static app:

- Microsoft Entra ID / Microsoft 365 authentication
- CRM opportunity synchronization and writeback
- Named-user role mapping and authenticated row-level security
- Teams and Outlook delivery
- Enterprise audit retention and analytics
