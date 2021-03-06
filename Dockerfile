FROM utarn/aspnetcore3.1-centos8:latest AS builder 
WORKDIR /src
COPY aspnetproject/aspnetproject.csproj aspnetproject/
RUN dotnet restore aspnetproject/aspnetproject.csproj
COPY . .
WORKDIR /src/aspnetproject
RUN dotnet publish --output /app --configuration Release

FROM utarn/aspnetcore3.1-centos8:latest
WORKDIR /app
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "aspnetproject.dll"]