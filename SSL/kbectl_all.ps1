Get-ChildItem -Recurse -Filter *.yaml | ForEach-Object { kubectl apply -f $_.FullName -n vijay-ingress }

http://techops.today/weather/api/WeatherForecast