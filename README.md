# Network Manager 🌐🔍

[![Python Version](https://img.shields.io/badge/python-3.8%2B-blue.svg)](https://www.python.org/)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Termux%2520-success.svg)](https://termux.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Network Manager** is a lightweight, robust Python-powered network administration, device discovery, and monitoring utility. Engineered with efficiency in mind, it is optimized to run seamlessly on standard Linux distributions as well as mobile Linux environments like Termux, giving you deep visibility into local network topologies, active hosts, open ports, and gateway configurations.

---

## 🚀 Key Features

* **Advanced Device Discovery:** Perform rapid ARP sweeps and subnet scans to map active hosts and connected devices on your local area network (LAN).
* **Port Scanning & Service Auditing:** Identify open ports, active services, and potential entry points across target IP addresses.
* **DNS Benchmarking:** Measure and compare resolution performance across custom DNS resolvers (such as Cloudflare, Google, and encrypted DNS endpoints).
* **Gateway Integration:** Automate interactions with local gateway routers (e.g., Huawei EchoLife ONTs) to parse session tokens, monitor active device lists, and audit gateway configurations.
* **Automated Watchdog & Alerts:** Continuous network state monitoring with instant notification dispatching via Telegram bot integration.
* **Lightweight & Modular:** Built cleanly in Python using native socket libraries and multi-threading for high performance with minimal resource overhead.

---

## 📁 Project Structure

```text
Network-manager-/
├── core/
│   ├── scanner.py       # ARP sweep and port scanning logic
│   ├── resolver.py      # DNS benchmarking and lookup utilities
│   └── gateway.py       # Router API interaction and session management
├── alerts/
│   └── telegram.py      # Telegram bot notification dispatcher
├── config/
│   └── settings.json    # Target subnets, credentials, and bot configurations
├── main.py              # CLI entry point and orchestration script
├── requirements.sh      # System dependency installer (apt/pkg)
├── requirements.txt     # Python package dependencies
└── README.md            # Project documentation
