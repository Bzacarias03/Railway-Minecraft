# Minecraft Forge Server



A containerized Minecraft Forge server running Minecraft 1.19.2 with Forge 43.5.2. A very bare bones installation ready for custom modification

## Overview

This is a fully configured Minecraft Forge server that includes:
- **Minecraft Version**: 1.19.2
- **Forge Version**: 43.5.2
- **Java Runtime**: OpenJDK 17 (Eclipse Temurin)
- **Base Image**: Alpine Linux
- **Default Memory**: 4GB RAM

## Features

- Dockerized deployment with persistent data storage
- Pre-configured Forge mod loader
- Railway deployment configuration included
- Automatic world and logs persistence via volume mounts
- Configurable JVM arguments

## Prerequisites

- Docker (for local deployment)
- Railway account (for Railway deployment)
- Git (for cloning the repository)

## Configuration

### Server Properties

Edit `server.properties` to customize server settings such as:
- Max players (default: 8)
- Difficulty (default: easy)
- Game mode (default: survival)
- Server port (default: 25565)
- Whitelist settings
- And more...

### JVM Arguments

Modify `user_jvm_args.txt` to adjust Java memory settings:
- Default: `-Xmx6G` (6GB maximum RAM)
- Adjust based on your server's available resources

### Forge Configuration

Forge-specific settings can be modified in:
- `config/fml.toml` - FML (Forge Mod Loader) configuration
- `config/forge-common.toml` - Common Forge settings
- `config/forge-resource-caching.toml` - Resource caching options

## Deployment

### Railway Deployment

1. **Connect Repository to Railway**
   - Create a new project on [Railway](https://railway.app)
   - Connect your GitHub repository
   - Railway will automatically detect the Dockerfile

2. **Configure Environment Variables** (if needed)
   - Railway will use the default configuration from `railway.toml`
   - The restart policy is set to "always" for automatic recovery

3. **Deploy**
   - Railway will automatically build and deploy on push
   - Generate a domain and TCP port. TCP port forwarding to 25565 (or custom port if needed)
   - Port will be exposed automatically

4. **Persistent Storage**
   - Railway volumes will persist world data and logs
   - Data is stored in `/minecraft/data` within the container

### Docker Deployment (Local)

1. **Build the Docker Image**
   ```bash
   docker build -t minecraft-forge-server .
   ```

2. **Run the Container**
   ```bash
   docker run -d \
     --name minecraft-server \
     -p 25565:25565 \
     -v minecraft-data:/minecraft/data \
     minecraft-forge-server
   ```

3. **Access the Server**
   - Connect using `localhost:25565` (or your server's IP)
   - View logs: `docker logs -f minecraft-server`
   - Access console: `docker exec -it minecraft-server /bin/sh`

## Server Management

### Accessing the Server Console

**Docker:**
```bash
docker exec -it minecraft-server /bin/sh
```

**Railway:**
- Use Railway's built-in terminal/console feature

### Common Commands

Once in the server console, you can use standard Minecraft server commands:
- `stop` - Stop the server gracefully
- `op <username>` - Grant operator status
- `whitelist add <username>` - Add player to whitelist
- `list` - List connected players
- `say <message>` - Broadcast a message

### Adding Mods

1. Create a `mods` directory in the project root (if it doesn't exist)
2. Add your `.jar` mod files to the `mods` directory
3. Rebuild and redeploy the Docker image

**Note:** Ensure mods are compatible with Minecraft 1.19.2 and Forge 43.5.2

### Viewing Logs

**Docker:**
```bash
docker logs -f minecraft-server
```

**Railway:**
- View logs in the Railway dashboard under your service

## File Structure

```
minecraft-server/
├── Dockerfile              # Docker container definition
├── railway.toml           # Railway deployment configuration
├── run.sh                 # Forge server startup script
├── start.sh               # Container entrypoint (generated in Dockerfile)
├── server.properties      # Minecraft server configuration
├── user_jvm_args.txt      # JVM memory and runtime arguments
├── eula.txt              # Minecraft EULA acceptance
├── config/               # Forge configuration files
│   ├── fml.toml
│   ├── forge-common.toml
│   └── forge-resource-caching.toml
├── libraries/            # Forge and Minecraft dependencies
├── ops.json              # Server operators list
├── whitelist.json        # Whitelisted players
├── banned-players.json   # Banned players list
└── banned-ips.json       # Banned IP addresses
```

## Persistent Data

The following data is persisted in `/minecraft/data`:
- `world/` - World save files
- `logs/` - Server log files

These directories are symlinked from the container's working directory to ensure data persistence across container restarts.

## Troubleshooting

### Server Won't Start
- Check that port 25565 is not already in use
- Verify Docker has sufficient resources allocated
- Review logs for Java errors or memory issues

### Connection Issues
- Ensure the server port (25565) is properly exposed
- Check firewall rules if deploying on a VPS
- Verify `server.properties` has correct IP/port settings

### Memory Issues
- Adjust `-Xmx` value in `user_jvm_args.txt` based on available RAM
- For Railway, ensure your plan has sufficient memory allocated

## License

See `LICENSE` file for details.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Support

For issues related to:
- **Minecraft/Forge**: Check the [Forge Forums](https://forums.minecraftforge.net/)
- **Docker**: Refer to [Docker Documentation](https://docs.docker.com/)
- **Railway**: See [Railway Documentation](https://docs.railway.app/)

