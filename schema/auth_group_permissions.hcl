table "auth_group_permissions" {
  schema = schema.public
  column "id" {
    null = false
    type = integer
    identity {
      generated = BY_DEFAULT
    }
  }
  column "group_id" {
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
  foreign_key "auth_group_permissions_group_id_fk" {
    columns     = [column.group_id]
    ref_columns = [table.auth_group.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "auth_group_permissions_permission_id_fk" {
    columns     = [column.permission_id]
    ref_columns = [table.auth_permission.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "auth_group_permissions_group_id_permission_id_uniq" {
    unique  = true
    columns = [column.group_id, column.permission_id]
  }
  index "auth_group_permissions_group_id" {
    columns = [column.group_id]
  }
  index "auth_group_permissions_permission_id" {
    columns = [column.permission_id]
  }
}
