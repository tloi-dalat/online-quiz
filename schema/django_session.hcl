table "django_session" {
  schema = schema.public
  column "session_key" {
    null = false
    type = character_varying(40)
  }
  column "session_data" {
    null = false
    type = text
  }
  column "expire_date" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.session_key]
  }
  index "django_session_expire_date" {
    columns = [column.expire_date]
  }
}
