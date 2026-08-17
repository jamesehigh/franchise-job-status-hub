# Franchise Job Status Hub

A shared job-status dashboard hosted with GitHub Pages and synchronized through Supabase.

## First-time database setup

1. Open the Supabase project.
2. Select **SQL Editor** and **New query**.
3. Paste the complete contents of [`supabase-setup.sql`](supabase-setup.sql).
4. Select **Run**.
5. Reload the deployed application. On its first successful connection, the app seeds Supabase with the embedded job dataset.

## Access model

This version deliberately uses open-link access. Anyone with the deployed site URL can read the dataset, edit job fields, reset edits, and upload a replacement workbook. The Supabase publishable key in `index.html` is intended for browser use; access is controlled by the row-level-security policies in `supabase-setup.sql`.

For restricted access, replace the anonymous policies with authenticated-user policies and add a login flow.

## Live behavior

- Job edits are written to `public.job_edits`.
- Uploaded workbook datasets are written to `public.app_state`.
- Supabase Realtime pushes changes to other open browsers.
- The **Edit Header** control saves a shared title, subtitle, and data label for each uploaded dataset.
- The embedded dataset remains a recovery snapshot if the database is unavailable.

## Site

The Pages workflow deploys the root of the `main` branch. The expected URL is:

<https://jamesehigh.github.io/franchise-job-status-hub/>
