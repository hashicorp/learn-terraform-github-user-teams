resource "github_membership" "all" {
  for_each = {
    for member in csvdecode(file("teams.csv")) :
    member.username => member
  }

  username = each.value.name
  role     = each.value.role
}