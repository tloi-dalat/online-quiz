table "django_admin_log" {
  schema = schema.public
  column "id" {
    null = false
    type = integer
    identity {
      generated = BY_DEFAULT
    }
  }
  column "action_time" {
    null = false
    type = timestamptz
  }
  column "object_id" {
    null = true
    type = text
  }
  column "object_repr" {
    null = false
    type = character_varying(200)
  }
  column "action_flag" {
    null = false
    type = smallint
  }
  column "change_message" {
    null = false
    type = text
  }
  column "content_type_id" {
    null = true
    type = integer
  }
  column "user_id" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "django_admin_log_content_type_id_fk" {
    columns     = [column.content_type_id]
    ref_columns = [table.django_content_type.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "django_admin_log_user_id_fk" {
    columns     = [column.user_id]
    ref_columns = [table.auth_user.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "django_admin_log_content_type_id" {
    columns = [column.content_type_id]
  }
  index "django_admin_log_user_id" {
    columns = [column.user_id]
  }
  check "django_admin_log_action_flag_check" {
    expr = "(action_flag >= 0)"
  }
}
