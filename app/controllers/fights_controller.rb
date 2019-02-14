# frozen_string_literal: true

class FightsController < ApplicationController
  before_action :set_character, only: %i[index create new]
  before_action :set_fight, only: %i[show edit update destroy launch take_turn]

  # GET /fights
  def index
    @fights = if @character
                @character.fights
              else
                Fight.all
              end
  end

  # GET /fights/1
  def show; end

  # GET /fights/new
  def new
    @fight = Fight.new
    @fight.fighter_left = @character
  end

  # GET /fights/1/edit
  def edit; end

  # POST /fights
  def create
    @fight = Fight.new(fight_params)

    respond_to do |format|
      if @fight.save!
        format.html { redirect_to @fight, notice: 'Fight was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /fights/1
  def update
    respond_to do |format|
      if @fight.update(fight_params)
        format.html { redirect_to @fight, notice: 'Fight was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /fights/1
  def destroy
    @fight.destroy

    respond_to do |format|
      format.html { redirect_to fights_url, notice: 'Fight was successfully destroyed.' }
    end
  end

  def launch
    @fight.launch

    respond_to do |format|
      format.html { redirect_to @fight, notice: 'The fight begins.' }
    end
  end

  def take_turn
    @fight.take_turn
    @fight.clean

    respond_to do |format|
      format.html { redirect_to @fight }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_fight
    @fight = Fight.find(params[:id])
  end

  def set_character
    @character = current_user.characters.find_by(id: params[:character_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def fight_params
    params
      .require(:fight)
      .permit(%i[
                fighter_right_id
                fighter_left_id
              ])
  end
end
