# Use the official .NET image as a base
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Use SDK image for build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["ChoreApp.Api/ChoreApp.Api.csproj", "ChoreApp.Api/"]
RUN dotnet restore "ChoreApp.Api/ChoreApp.Api.csproj"
COPY . .
WORKDIR "/src/ChoreApp.Api"
RUN dotnet build "ChoreApp.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ChoreApp.Api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ChoreApp.Api.dll"]