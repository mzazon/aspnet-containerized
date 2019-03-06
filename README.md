## Build and run the sample with Docker

You can build and run the sample in Docker using the following commands. The instructions assume that you are in the root of the repository and running Windows Server 2019 for the sample.

```console
git clone https://github.com/mzazon/aspnet-containerized
cd aspnet-containerized
docker build --pull -t aspnetapp .
docker run --name aspnet_sample --rm -it -p 8000:80 aspnetapp
```

You should see the following console output as the application builds:

```console
PS C:\Users\Administrator\Desktop\aspnet-containerized> docker build --pull -t aspnetapp .
Sending build context to Docker daemon  1.718MB
Step 1/12 : FROM microsoft/dotnet-framework:4.7.2-sdk AS build
4.7.2-sdk: Pulling from microsoft/dotnet-framework
65014b3c3121: Already exists
9e2f2b17be72: Already exists
e583fcdc4adc: Already exists
9870ac56a9c6: Pull complete
Digest: sha256:590e9ddadfdac37e9c2b58f2b33ebbbd4393e8102ec0da783add291ba4ace511
Status: Downloaded newer image for microsoft/dotnet-framework:4.7.2-sdk
 ---> 1f9f0521b131
Step 2/12 : WORKDIR /app
 ---> Running in 98cc90b9f18d
Removing intermediate container 98cc90b9f18d
 ---> 4147b08d4b91
Step 3/12 : COPY *.sln .
 ---> 5de8e2c1a9fc
Step 4/12 : COPY aspnetapp/*.csproj ./aspnetapp/
 ---> 4a581c162a8d
Step 5/12 : COPY aspnetapp/*.config ./aspnetapp/
 ---> d8907420bc30
Step 6/12 : RUN nuget restore
 ---> Running in 727b8fc48d3c
Installed:
    25 package(s) to packages.config projects
Removing intermediate container 727b8fc48d3c
 ---> 98a072d1c02d
Step 7/12 : COPY aspnetapp/. ./aspnetapp/
 ---> 0236cfe1993c
Step 8/12 : WORKDIR /app/aspnetapp
 ---> Running in ce5ad2bae874
Removing intermediate container ce5ad2bae874
 ---> c16dd8b9ed4a
Step 9/12 : RUN msbuild /p:Configuration=Release
 ---> Running in d4248ba054e1
Microsoft (R) Build Engine version 15.9.21+g9802d43bc3 for .NET Framework
Copyright (C) Microsoft Corporation. All rights reserved.

Build started 3/6/2019 4:23:00 PM.
Done Building Project "C:\app\aspnetapp\aspnetapp.csproj" (default targets).

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:05.28
Removing intermediate container d4248ba054e1
 ---> fc0ebee6c12d
Step 10/12 : FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2 AS runtime
4.7.2: Pulling from dotnet/framework/aspnet
Digest: sha256:958114016f74f4ffc10b7f065ca4f340e0a0c390cb276c3659d5f8af43d388c7
Status: Downloaded newer image for mcr.microsoft.com/dotnet/framework/aspnet:4.7.2
 ---> c231abd0f40f
Step 11/12 : WORKDIR /inetpub/wwwroot
 ---> Running in 545958a64f0a
Removing intermediate container 545958a64f0a
 ---> aad0f811675f
Step 12/12 : COPY --from=build /app/aspnetapp/. ./
 ---> 2f66925575d3
Successfully built 2f66925575d3
Successfully tagged aspnetapp:latest
PS C:\Users\Administrator\Desktop\aspnet-containerized>
```

You should see the following when running the application:

```console
PS C:\Users\Administrator\Desktop\aspnet-containerized>docker run --name aspnet_sample --rm -it -p 8000:80 aspnetapp
Service 'w3svc' has been stopped

Service 'w3svc' started
```

After the application starts, navigate to `http://localhost:8000` in your web browser!