# WireGuard Helper Script

This project provides a simple Bash script (`setup.sh`) to facilitate the setup, configuration, and management of WireGuard on Linux. The script automates the installation, uninstallation, and configuration update processes, making it easier to work with WireGuard for secure networking.

## Features
- **Installation**: Sets up the necessary configuration files.
- **Uninstallation**: Completely removes the project and related files.
- **Configuration Updates**: Update the WireGuard configuration.

## Getting Started

### Prerequisites
- **WireGuard** must be installed on your system.
- **Systemd** support is required to manage the WireGuard service.

### Installation

To install the script and configure WireGuard, run:
```bash
sudo bash setup.sh install
```

This command creates WireGuard Configuration file to /etc/laefye-wireguard/wireguard.config and create new systemd daemon `laefye-wireguard`

### Uninstallation

To completely remove the script and all configurations:
```bash
sudo bash setup.sh uninstall
```

### Updating Configuration

To add new peers or update existing configurations:
```bash
sudo bash setup.sh update-config
```

## First run
- You need clone this repository and `wg genkey` to `keys/wg.private` and (for example) `wg genkey` to `keys/user.private`
- Add your user.private (uncomment) in `templates/wireguard.conf.template`
- `sudo bash setup.sh install`
- `sudo systemctl enable laefye-wireguard`
- `sudo systemctl start laefye-wireguard`
- `sudo wg` - To show public key of your server

## Add a peer
You need generate **private key** to `keys/` and add new peer entries to `wireguard.conf.template`

## Directory Structure

- **keys/**: Stores private keys for WireGuard peers.
- **templates/**: Bash template scripts

## Managing the Service

After installation, enable and start the WireGuard service:
```bash
sudo systemctl enable laefye-wireguard
sudo systemctl start laefye-wireguard
```

These commands ensure that WireGuard will start automatically on boot and can be managed as a standard service.

## Contributing

Feel free to submit issues or make pull requests to improve this script.

## License

This project is licensed under the MIT License.
