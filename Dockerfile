FROM mcr.microsoft.com/dotnet/sdk:6.0

# just some unique package name
ARG PROJECT_NAME=foo_JP5m
ARG MAJOR_VERSION=1
ARG MINOR_VERSION=0
# date +%y%m%d%H%M%S
ARG PATCH_VERSION=0
ARG NUGET_SOURCE=https://api.nuget.org/v3/index.json
# secret
ARG API_KEY=null

ENV VERSION=${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}
ENV NUGET_PATH=output

WORKDIR /app

COPY ${PROJECT_NAME}.csproj ./

RUN dotnet restore
COPY . .

RUN dotnet build
RUN dotnet pack -p:PackageVersion=${VERSION} --output ${NUGET_PATH}
RUN dotnet nuget push ${NUGET_PATH}/*.nupkg -k ${API_KEY} -s ${NUGET_SOURCE}