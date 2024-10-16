let 
  Source = Json.Document(Web.Contents("https://myJira.fr/rest/api/2/search?jql=project=00000&maxResults=1000"", [Headers=[Authorization="Bearer " & jira_token]]))[issues]
in 
  Source
