# Mirror the whole bus network into a local SQLite cache

The LTA arrivals API is thin: it returns only currently-running Bus Services for a stop, and
identifies destinations by code rather than name. To show destination names, to show Services
that exist but are *not in operation*, and to power search and nearby-stop lookups instantly, the
app needs the full network reference data on hand.

We decided to mirror the entire network — all Bus Stops, Bus Services, and Bus Routes (~31,500 rows)
— from LTA Datamall into a local Drift/SQLite database on first launch, and serve everything except
live arrivals from that mirror. The driver is **performance**: keep this reference data inside the
app rather than making many paged, slow LTA reference calls per screen.

The cache is refreshed by re-pulling the full network on first launch and every 30 days thereafter
(tracked via `LocalStorageService`). **30 days is a pragmatic round number, not tied to how often LTA
actually changes routes** — it trades a window of staleness for far fewer network calls.

## Consequences

- First launch is heavy (~31,500 rows, paged at 500); the `dBInitProvider` loading UI exists
  specifically to cover this download.
- Route/service changes can be up to 30 days stale on a device.
- "Not in operation" Services are reconstructed client-side by diffing live arrivals against the
  cached Bus Routes for a stop.
