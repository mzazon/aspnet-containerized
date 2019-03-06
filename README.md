# ASP.NET Docker Sample

The sample builds the application in a container based on the larger [.NET Framework SDK Docker image](https://hub.docker.com/r/microsoft/dotnet-framework/). It builds the application and then copies the final build result into a Docker image based on the smaller [ASP.NET Runtime Docker image](https://hub.docker.com/r/microsoft/aspnet/). It uses Docker [multi-stage build](https://github.com/dotnet/announcements/issues/18) and [multi-arch tags](https://github.com/dotnet/announcements/issues/14).

This sample requires [Docker 17.06](https://docs.docker.com/release-notes/docker-ce) or later of the [Docker client](https://store.docker.com/editions/community/docker-ce-desktop-windows).

## Build and run the sample with Docker

You can build and run the sample in Docker using the following commands. The instructions assume that you are in the root of the repository.

```console
docker build --pull -t aspnetapp .
docker run --name aspnet_sample --rm -it -p 8000:80 aspnetapp
```

You should see the following console output as the application starts.

```console
C:\git\dotnet-framework-docker\samples\aspnetapp>docker run --name aspnet_sample --rm -it -p 8000:80 aspnetapp
Service 'w3svc' has been stopped

Service 'w3svc' started
```

After the application starts, navigate to `http://localhost:8000` in your web browser. You need to navigate to the application via IP address instead of `localhost` for earlier Windows versions, which is demonstrated in [View the ASP.NET app in a running container on Windows](https://github.com/microsoft/dotnet-framework-docker/blob/master/samples/aspnetapp/README.md#view-the-aspnet-app-in-a-running-container-on-windows).

Note: The `-p` argument maps port 8000 on your local machine to port 80 in the container (the form of the port mapping is `host:container`). See the [Docker run reference](https://docs.docker.com/engine/reference/commandline/run/) for more information on commandline parameters.

Multiple variations of this sample have been provided, as follows. Some of these example Dockerfiles are demonstrated later. Specify an alternate Dockerfile via the `-f` argument.

* [Sample with basic build using multi-arch tags](Dockerfile)
* [Sample for Windows Server Core LTSC 2016](Dockerfile.windowsservercore-ltsc2016)

### View the ASP.NET app in a running container on Windows

After the application starts, navigate to the container IP (as opposed to http://localhost) in your web browser with the the following instructions:

1. Open up another command prompt.
1. Run `docker exec aspnet_sample ipconfig`.
1. Copy the container IP address and paste into your browser (for example, `172.29.245.43`).

See the following example of how to get the IP address of a running Windows container.

```console
C:\git\dotnet-framework-docker\samples\aspnetapp>docker exec aspnet_sample ipconfig

Windows IP Configuration


Ethernet adapter Ethernet:

   Connection-specific DNS Suffix  . : contoso.com
   Link-local IPv6 Address . . . . . : fe80::1967:6598:124:cfa3%4
   IPv4 Address. . . . . . . . . . . : 172.29.245.43
   Subnet Mask . . . . . . . . . . . : 255.255.240.0
   Default Gateway . . . . . . . . . : 172.29.240.1
```

Note: [`docker exec`](https://docs.docker.com/engine/reference/commandline/exec/) supports identifying containers with name or hash. The container name is used in the preceding instructions. `docker exec` runs a new command (as opposed to the [entrypoint](https://docs.docker.com/engine/reference/builder/#entrypoint)) in a running container.

Some people prefer using `docker inspect` for this same purpose, as demonstrated in the following example.

```console
C:\git\dotnet-framework-docker\samples\aspnetapp>docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" aspnetcore_sample
172.25.157.148
```
