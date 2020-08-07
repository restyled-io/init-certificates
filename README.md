# `init-certificates`

Docker image for producing TLS certificates for use by a Docker server/client.

This is a poor imitation of `docker-machine regenerate-certs`, as a shell
script, run in the `nginx` Docker image.

## Example Usage

Generate certificates:

```console
docker run --rm --volume $PWD:/certs \
  restyled/init-certificates -H {hostname} -i {ip}
```

Start the daemon:

```console
sudo dockerd \
  --tlsverify \
  --tlscacert=ca.pem \
  --tlscert=server_cert.pem \
  --tlskey=server_key.pem \
  -H=0.0.0.0:2376
```

Connect with a client

```console
$ mkdir -pv ~/.docker
$ sudo cp -v {ca,cert,key}.pem ~/.docker
$ sudo chown $USER:$USER ~/.docker/*.pem
$ export DOCKER_TLS_VERIFY=1
$ export DOCKER_HOST=tcp://{hostname or ip}:2376
docker ps
```

## Caveat

This is not intended to make robust certificates for use in your broader
infrastructure. I use it to make a CA and Certificates local to a single,
ephemeral "build box". That said, if anyone wants to make this more secure, PRs
welcome.

---

[LICENSE](./LICENSE)
