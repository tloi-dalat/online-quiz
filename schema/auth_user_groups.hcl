table "auth_user_groups" {
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
  column "group_id" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "auth_user_groups_user_id_fk" {
    columns     = [column.user_id]
    ref_columns = [table.auth_user.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "auth_user_groups_group_id_fk" {
    columns     = [column.group_id]
    ref_columns = [table.auth_group.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "auth_user_groups_user_id_group_id_uniq" {
    unique  = true
    columns = [column.user_id, column.group_id]
  }
  index "auth_user_groups_user_id" {
    columns = [column.user_id]
  }
  index "auth_user_groups_group_id" {
    columns = [column.group_id]
  }
}
