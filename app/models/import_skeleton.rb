require_relative './data_importer'

resourceId = 'bc4b4f54-ec69-4620-95ee-773d75f5460f'
table_name = 'table_name'

DataImporter.get_sampling(resourceId, table_name)
