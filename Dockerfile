FROM mcr.microsoft.com/azure-cli

ADD acr-cleanup.ps1 /

RUN mkdir /opt/powershell \
	&& wget https://github.com/PowerShell/PowerShell/releases/download/v7.0.3/powershell-7.0.3-linux-alpine-x64.tar.gz -O - | tar -xz -C /opt/powershell \
	&& ln -s /opt/powershell/pwsh /usr/local/bin

