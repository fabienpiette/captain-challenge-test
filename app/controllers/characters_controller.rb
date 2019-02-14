# frozen_string_literal: true

class CharactersController < ApplicationController
  before_action :set_character, only: %i[edit update destroy]

  # GET /characters
  def index
    @characters = current_user.characters
  end

  # GET /characters/new
  def new
    @character = current_user.characters.new
    @character.equipments.build
  end

  # GET /characters/1/edit
  def edit
    @character.equipments.build if @character.equipments.blank?
  end

  # POST /characters
  def create
    @character = current_user.characters.new(character_params)

    if @character.save
      redirect_to characters_url,
                  success: 'Character was successfully created.'
    else
      flash[:danger] = @character.errors.full_messages.join('. ')
      render :new
    end
  end

  # PATCH/PUT /characters/1
  def update
    if @character.update(character_params)
      redirect_to [:edit, @character],
                  success: 'Character was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /characters/1
  def destroy
    @character.destroy

    redirect_to characters_url, success: 'Character was successfully destroyed.'
  end

  protected

  # Use callbacks to share common setup or constraints between actions.
  def set_character
    @character = current_user.characters.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def character_params
    params
      .require(:character)
      .permit(%i[
                name
                gladiator_type_id
                avatar
                weapon_ids
                shield_ids
              ])
  end
end
