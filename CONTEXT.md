# SG Land Transport

A Flutter app (the Dart package `lta_datamall_flutter`) that lets riders look up a Singapore
bus stop and see live arrival status for every bus serving it — including how crowded each
incoming bus is. Built entirely on the public [LTA Datamall](https://datamall.lta.gov.sg) APIs.

**Scope:** Today the app covers **buses only**. The "Land Transport" name is deliberate — MRT/LRT
trains, road traffic, and carpark availability are intended future modes, not out of scope. The
architecture (network mirror, stop-centric navigation, the glossary below) is bus-shaped today but
expected to grow multi-modal.

## Language

### Network

**Bus Stop**:
A physical boarding point, identified by a 5-digit `busStopCode`. Has a road name, a
description (its common name), and a lat/long. The app is organized around the bus stop:
the rider picks one and sees what is coming.
_Avoid_: station, stand.

**Bus Service**:
A numbered bus line **in one direction** (e.g. "147" outbound and "147" inbound are two
distinct Bus Services). Defines the line's origin, destination, category, and frequency
bands. Identified by `serviceNo` + `direction`.
_Avoid_: line, route (for this concept), trip.

**Bus Route**:
The ordered list of Bus Stops a Bus Service visits, one entry per stop, carrying the
stop's position in the sequence (`stopSequence`) and its distance along the line.
_Avoid_: path, itinerary, journey.

**Service Number** (`serviceNo`):
The human-facing bus number (e.g. "147") printed on the bus. A shared identifier that
appears on Bus Services, Bus Routes, and Bus Arrivals — not a concept of its own.

**Direction**:
Which way a Bus Service runs along its line, as an integer (1 or 2). The same Service
Number has one Bus Service row per direction. Derived in lookups from the destination.

**Operator**:
The company running a Bus Service (e.g. SBS Transit, SMRT). Carried as a code on Services,
Routes, and Arrivals.
_Avoid_: company, provider.

### Live status

**Bus Arrival**:
The live, estimated-arrival view for one Bus Service at one Bus Stop, as returned by the
LTA arrivals API at request time. Carries up to three incoming buses.
_Avoid_: prediction, ETA (for the whole record).

**Next Bus**:
A single incoming bus within a Bus Arrival — its estimated arrival time, current
lat/long, and crowding level. A Bus Arrival holds Next Bus, Next Bus 2, and Next Bus 3.
_Avoid_: upcoming bus, arrival slot.

**Load**:
How crowded an incoming Next Bus is — the headline "how full is the bus" status. Surfaced
to riders as one of three levels: **Seats Avail.** (`SEA`), **Standing Avail.** (`SDA`), and
**Limited Standing** (`LSD`), each shown as a colored marker on the arrival time.
_Avoid_: crowding, occupancy, capacity.

**In Service / Not In Operation**:
Whether a Bus Service is currently running. The arrivals API only returns Services that
are running; the app reconstructs the *not in operation* Services for a stop by diffing
the live arrivals against the Bus Routes cached locally, so the rider still sees that the
Service exists but isn't running now.
_Avoid_: active/inactive, online/offline.

### Personalization

**Favorite**:
A Bus Stop + Service Number pair the rider has pinned, so they can jump straight to that
specific bus at that specific stop. Stored locally as `busStopCode|serviceNo`. (An earlier
version pinned whole Bus Stops; those "legacy favorites" are migrated to per-service ones.)
_Avoid_: bookmark, saved, pinned.

**Nearby Bus Stop**:
A Bus Stop ranked by its distance from the rider's current location. Distance is computed
on-device from the rider's GPS position to the stop's lat/long.
_Avoid_: closest, local.
