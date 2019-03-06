FROM microsoft/dotnet-framework:4.7.2-sdk AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY aspnetapp/*.csproj ./aspnetapp/
COPY aspnetapp/*.config ./aspnetapp/
RUN nuget restore

# copy everything else and build app
COPY aspnetapp/. ./aspnetapp/
WORKDIR /app/aspnetapp
RUN msbuild /p:Configuration=Release


FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/aspnetapp/. ./
RUN powershell.exe -Command " \
    Import-Module IISAdministration; \
    $cert = New-SelfSignedCertificate -DnsName demo.cloudreach.internal -CertStoreLocation cert:\LocalMachine\My; \
    $certHash = $cert.GetCertHash(); \
    $sm = Get-IISServerManager; \
    $sm.Sites[\"Default Web Site\"].Bindings.Add(\"*:443:\", $certHash, \"My\", \"0\"); \
    $sm.CommitChanges();"