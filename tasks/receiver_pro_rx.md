# Task: Receiver Nano Professional Upgrade

## Context
Improve the Arduino Nano receiver (`Receiver_Nano.ino`) to include professional features:
1. **Connection LED Feedback**: Visual status of the link.
2. **Link Quality (LQ) Telemetry**: Internal receive success rate sent back to TX.
3. **Optimized Logic**: Smoother performance and better code structure.

## Technical Details
- **Hardware**: Arduino Nano + nRF24L01.
- **Connection LED**: PIN 13 (Built-in).
- **Communication**: 2.4GHz nRF24L01 (Channel 120, 250kbps).
- **Telemetry Protocol**: AckPayload with a shared data structure.

## Plan

### Phase 1: Shared Protocol Definition
- Define a shared struct `AckData` for both Transmitter and Receiver.
  ```cpp
  struct AckData {
    float vbat;
    byte lq;
  };
  ```

### Phase 2: Updating Receiver (`Receiver_Nano.ino`)
- Add `LED_PIN 13` definition.
- Implement packet counting for LQ.
- Update `AckPayload` with the new struct.
- Handle LED blinking patterns (5Hz searching, Solid connected).

### Phase 3: Updating Transmitter (`Transmitter_ESP.ino`)
- Update `rfLoop` to receive the full `AckData` struct.
- Combine RX-reported LQ with TX success rate for a more accurate Link Quality display.

### Phase 4: Maintenance & Logs
- Update `backlog.md` with [Geliştirme-019].
- Update `testlog.md` with [TEST-019].

## Verification Criteria
- LED Blinks fast (5Hz) when transmitter is OFF.
- LED stays SOLID when transmitter is ON.
- TX display shows RX Voltage and % LQ correctly.
