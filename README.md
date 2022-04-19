# Workshop med Azure DevOps Pipeline og Uptime Kuma #

Workshop som bruker Azure DevOps Pipeline og Uptime Kuma til å lage automatisk monitorering

## Legg til en pipeline i Azure DevOps

### Mål

I denne workshoppen skal vi legge til en pipeline som kjører noen tester automatisk og rapporterer til et monitor dashboard.

### Hvorfor

Dette viser hvordan du kan enkelt komme i gang med å bruke en CI/CD pipeline til å sette i gang testscript som tester en tjeneste. Denne pipelinen vil kjøre jevnlig, men også ved hver endring i testen som blir lagret.


![image-20220419115015924](wiki/images/image-20220419115015924.png)

Vi skal bruker Azure DevOps til å kjøre et script som oppdaterer  [Uptime]( https://github.com/louislam/uptime-kuma) som er en monitortjeneste.

**Steg 1 - Logg inn i Azure DevOps**

- Gå til https://dev.azure.com/soprasteria/Workshop-DevOps-Test/_build
- Logg inn med Sopra Steria brukeren

**Steg 2 - Lag ny pipeline**

- Trykk på "**New pipeline**"

![image-20220419112955473](wiki/images/image-20220419112955473.png)

- Velg "**GitHub**"
- Skriv inn: **sopra-steria-norge/workshop-uptime-kuma** i søkeboksen og velg det som dukker opp

![image-20220419113302399](wiki/images/image-20220419113302399.png)

- Velg "**Exisiting Azure Pipelines YAML file**" og velg "**/azure-pipeline.yml**"

![image-20220419113511430](wiki/images/image-20220419113511430.png)

- Trykk på "**Continue**"
- Trykk på "**Run**"

Da skal du få noe som ser omtrent slik ut:

![image-20220419113824901](wiki/images/image-20220419113824901.png)

Pilen viser navnet på pipelinen.



**Steg 3 - Se på kjøringen**

- Trykk på "**Job**"

![image-20220419114131095](wiki/images/image-20220419114131095.png)

- Trykk på "**Check Uptime status**"

Denne tekskten viser at Uptime er responsiv og sender melding til Uptime at den er OK :)



**Steg 4 - Se på monitor dashboard**

- Gå til https://uptime-app.azurewebsites.net/dashboard

![image-20220419114517345](wiki/images/image-20220419114517345.png)

Denne monitoren viser at status er OK.





```
name: $(Date:yyyyMMdd)$(Rev:.r)

trigger:
  branches:
    include:
    - main

    # https://crontab.guru/#*/30_*_*_*_*
schedules:
  - cron: "*/30 * * * *"
    displayName: At every 30th minute
    branches:
      include:
        - main
    always: true

    
steps:
- script: ls '$(System.DefaultWorkingDirectory)'

- script: |
    bash testscript/test_running_process.sh
  displayName: Check Uptime status

```





