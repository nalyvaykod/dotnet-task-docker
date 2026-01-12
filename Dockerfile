FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY . .

RUN dotnet tool install --global dotnet-ef --version 8.*
ENV PATH="$PATH:/root/.dotnet/tools"

RUN dotnet restore "DotNetCrudWebApi/DotNetCrudWebApi.csproj"

RUN dotnet ef migrations bundle --project "DotNetCrudWebApi/DotNetCrudWebApi.csproj" -o /app/publish/efbundle --self-contained -r linux-x64

RUN dotnet publish "DotNetCrudWebApi/DotNetCrudWebApi.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
EXPOSE 8080

RUN mkdir -p /app/data

COPY --from=build /app/publish .

RUN echo '#!/bin/sh' > entrypoint.sh \
    && echo 'echo "Starting Migrations..."' >> entrypoint.sh \
    && echo './efbundle --connection "Data Source=/app/data/App.db"' >> entrypoint.sh \
    && echo 'echo "Migrations finished. Starting App..."' >> entrypoint.sh \
    && echo 'dotnet DotNetCrudWebApi.dll' >> entrypoint.sh \
    && chmod +x entrypoint.sh

RUN chmod +x efbundle

RUN chmod -R 777 /app/data

ENTRYPOINT ["./entrypoint.sh"]