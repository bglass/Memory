NEXTCLOUD_DB = YAML.load_file(File.join(Rails.root, "config", "nextcloud_database.yml"))[Rails.env.to_s]  
