table "auth_user_user_permissions" {
  schema = schema.public
  column "id" {
    null = false
    type = integer
    identity {
      generated = BY_DEFAULT
    }
  }
  column "user_id" {
    null = false
    type = integer
  }
  column "permission_id" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "auth_user_user_permissions_user_id_fk" {
    columns     = [column.user_id]
    ref_columns = [table.auth_user.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "auth_user_user_permissions_permission_id_fk" {
    columns     = [column.permission_id]
    ref_columns = [table.auth_permission.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "auth_user_user_permissions_user_id_permission_id_uniq" {
    unique  = true
    columns = [column.user_id, column.permission_id]
  }
  index "auth_user_user_permissions_user_id" {
    columns = [column.user_id]
  }
  index "auth_user_user_permissions_permission_id" {
    columns = [column.permission_id]
  }
}
