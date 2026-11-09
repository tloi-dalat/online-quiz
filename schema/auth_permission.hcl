table "auth_permission" {
  schema = schema.public
  column "id" {
    null = false
    type = integer
    identity {
      generated = BY_DEFAULT
    }
  }
  column "name" {
    null = false
    type = character_varying(255)
  }
  column "content_type_id" {
    null = false
    type = integer
  }
  column "codename" {
    null = false
    type = character_varying(100)
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "auth_permission_content_type_id_fk" {
    columns     = [column.content_type_id]
    ref_columns = [table.django_content_type.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "auth_permission_content_type_id_codename_uniq" {
    unique  = true
    columns = [column.content_type_id, column.codename]
  }
  index "auth_permission_content_type_id" {
    columns = [column.content_type_id]
  }
}
