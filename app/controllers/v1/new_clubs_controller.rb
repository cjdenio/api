# frozen_string_literal: true

module V1
  class NewClubsController < ApiController
    include UserAuth

    def index
      return render_access_denied unless current_user.admin?

      render_success NewClub.all
    end

    def show
      club = NewClub.find(params[:id])
      authorize club

      render_success club
    end

    def update
      club = NewClub.find(params[:id])
      authorize club

      if club.update_attributes(club_params)
        render_success club
      else
        render_field_errors club.errors
      end
    end

    private

    def club_params
      params.permit(
        :high_school_name,
        :high_school_type,
        :high_school_address,
        :high_school_start_month,
        :high_school_end_month,
        :club_website
      )
    end
  end
end
