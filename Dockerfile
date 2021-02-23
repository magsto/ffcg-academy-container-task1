FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://*:5000

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["ffcg-academy-container-task1.csproj", "./"]
RUN dotnet restore "ffcg-academy-container-task1.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "ffcg-academy-container-task1.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ffcg-academy-container-task1.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ffcg-academy-container-task1.dll"]
