module Hub

  # Operations for managing private asset files.
  class PrivateAssets

    # Copies private items into the _site directory.
    #
    # More correctly, it prepares private items for copying, which happens at
    # site generation time.
    # +site+:: Jekyll site object
    def self.copy_to_site(site)
      copy_team_images(site)
    end

    # Determines whether or not a private asset is present.
    # +site+:: Jekyll site data
    # +relative_path+:: path of asset relative to private_data_path config
    def self.exists? (site, relative_path)
      File.exists? File.join(
        site.source, site.config['private_data_path'], relative_path)
    end

    # Copies team image files from +site.config[+'private_data_path'] to the
    # generated site directory.
    # +site+:: Jekyll site object
    def self.copy_team_images(site)
      private_root = File.join(site.source, site.config['private_data_path'])
      img_dir = site.config['team_img_dir']

      source_dir = File.join(private_root, img_dir)
      return unless Dir.exists? source_dir
      d = Dir.open(source_dir)
      d.each do |filename|
        next if ['.', '..'].include? filename
        site.static_files << ::Jekyll::StaticFile.new(
          site, private_root, img_dir, filename)
      end
    end
  end
end
