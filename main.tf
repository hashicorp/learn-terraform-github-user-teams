provider "github" {}

# Create local values to retrieve items from CSVs
locals {
  # Parse team member files
  team_members_path = "team-members"
  team_members_files = {
    for file in fileset(local.team_members_path, "*.csv") :
    trimsuffix(file, ".csv") => csvdecode(file("${local.team_members_path}/${file}"))
  }
  team_members_temp = flatten([
    for team, members in local.team_members_files : [
      for tn, t in github_team.all : {
        name    = t.name
        id      = t.id
        slug    = t.slug
        members = members
      } if t.slug == team
    ]
  ])
  team_members_temp2 = {
    for team in local.team_members_temp :
    team.name => team
  }

  team_members = flatten([
    for team in local.team_members_temp2 : [
      for member in team.members : {
        name     = "${team.slug}-${member.username}"
        team_id  = team.id
        username = member.username
        role     = member.role
      }
    ]
  ])

  # Parse repo team membership files
  repo_teams_path = "repos-team"
  repo_teams_files = {
    for file in fileset(local.repo_teams_path, "*.csv") :
    trimsuffix(file, ".csv") => csvdecode(file("${local.repo_teams_path}/${file}"))
  }
}

# Retrieve information about the currently (PAT) authenticated user
data "github_user" "self" {
  username = ""
}