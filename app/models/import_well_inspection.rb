require_relative './data_saver'

resourceId = 'e8024ac8-ea92-4dc9-99f7-8d58de3e1473'
table_name = 'well_inspections'

DataSaver.save_resources(resourceId, table_name)
