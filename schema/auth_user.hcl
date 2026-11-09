table "auth_user" {
  schema = schema.public
  column "id" {
    null = false
    type = integer
    identity {
      generated = BY_DEFAULT
    }
  }
  column "password" {
    null = false
    type = character_varying(128)
  }
  column "last_login" {
    null = true
    type = timestamptz
  }
  column "is_superuser" {
    null = false
    type = boolean
  }
  column "username" {
    null = false
    type = character_varying(150)
  }
  column "first_name" {
    null = false
    type = character_varying(150)
  }
  column "last_name" {
    null = false
    type = character_varying(150)
  }
  column "email" {
    null = false
    type = character_varying(254)
  }
  column "is_staff" {
    null = false
    type = boolean
  }
  column "is_active" {
    null = false
    type = boolean
  }
  column "date_joined" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.id]
  }
  index "auth_user_username_uniq" {
    unique  = true
    columns = [column.username]
  }
}
