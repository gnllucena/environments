FROM microsoft/dotnet:2.2.2-runtime-alpine3.8 as deploy
WORKDIR /app
COPY ./ .
ENTRYPOINT ["dotnet", "Consumidor.dll"]