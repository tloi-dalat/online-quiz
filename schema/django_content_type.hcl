table "django_content_type" {
  schema = schema.public
  column "id" {
    null = false
    type = integer
    identity {
      generated = BY_DEFAULT
    }
  }
  column "app_label" {
    null = false
    type = character_varying(100)
  }
  column "model" {
    null = false
    type = character_varying(100)
  }
  primary_key {
    columns = [column.id]
  }
  index "django_content_type_app_label_model_uniq" {
    unique  = true
    columns = [column.app_label, column.model]
  }
}
