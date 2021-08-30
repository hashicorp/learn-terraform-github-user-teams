resource "github_team" "all" {
  for_each = {
    for team in csvdecode(file("teams.csv")) :
    team.name => team
  }

  name        = each.value.name
  description = each.value.description
  privacy     = each.value.privacy
}

# This resource will add the currently authenticated user as a member of `my_team`
resource "github_team_membership" "self" {
  for_each = github_team.all

  team_id  = each.value.id
  username = data.github_user.self.login
  role     = "maintainer"
}

resource "github_team_membership" "members" {
  for_each = { for tm in local.team_members : tm.name => tm }

  team_id  = each.value.team_id
  username = each.value.username
  role     = each.value.role
}
