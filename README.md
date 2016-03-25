# Docker Magento

This is the Copious Inc. Docker environment to run Magento. Follow the instructions below to get Magento running in your local development environment.

## Install Docker

If you're on OS X or Windows, install [Docker Toolbox](https://www.docker.com/products/docker-toolbox)

If you're on Linux, follow the instructions to [Install Docker on Linux](https://docs.docker.com/linux/step_one/).
You'll also need to install [Docker Machine](https://docs.docker.com/machine/install-machine/) and
[Docker Compose](https://docs.docker.com/compose/install/)

### Run Magento 1.x in Docker

Build a local docker image for Magento 1.x using the Copious docker-magento repository.

```bash
docker build -t copious/magento:onbuild https://github.com/copious/docker-magento.git#:v1/onbuild
```

Download the source code for the Magento edition and version you want to run. Copy the archive into the project root. Unarchive the files into a directory named `magento` inside your project root, like so:

```sh
tar -xzf magento-x.x.x.x.tar.gz --strip-components=1 -C magento
rm magento-x.x.x.x.tar.gz
```

If you want to add the Magento sample data to your store, download the Magento sample data archive that corresponds to the version of Magento you downloaded. Unarchive the files, copy the media files into the `magento` directory and add the sample data SQL file to your project root.

Create a `Dockerfile` in your project root using the `copious/magento:onbuild` image you built earlier.

```Dockerfile
FROM copious/magento:onbuild
```

Lookup the IP address for the Docker Machine host running docker:

```bash
docker-machine ip default
```

On OS X or Linux, open your `/etc/hosts` file (with appropriate permissions) and add a hostname entry for the Docker Machine IP address.

```
192.168.99.100     magento.dev
```

Copy the sample `docker-compose.yml` file from the root of this repository to your project root. Start your Magento environment from the project root using Docker Compose:

```bash
docker-compose up -d
```

Navigate to the

## TODO

* Explain composer and dependency installation
* Explain using auth.json for composer (add excluding from source control with .gitignore)
* Explain USER_ID issue on Mac OS X
