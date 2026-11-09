table "django_site" {
  schema = schema.public
  column "id" {
    null = false
    type = integer
    identity {
      generated = BY_DEFAULT
    }
  }
  column "domain" {
    null = false
    type = character_varying(100)
  }
  column "name" {
    null = false
    type = character_varying(50)
  }
  primary_key {
    columns = [column.id]
  }
  index "django_site_domain_uniq" {
    unique  = true
    columns = [column.domain]
  }
}
