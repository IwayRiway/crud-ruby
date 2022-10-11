class PostinganController < ApplicationController
  include ApplicationHelper
  before_action :permission, except: [:create, :update, :detail]
  before_action :set_postingan, only: %i[ detail edit update destroy ]
  before_action :authenticate_user!

  def index
    @data = Postingan.all
  end

  def detail
    # @data = Postingan.find(params[:id])
  end

  def input
  end

  def create
    @data = Postingan.new(judul: params[:judul], deskripsi: params[:deskripsi])
    # @data = Postingan.new(postingan_params)
    @data.save

    flash[:pesan] = "Data Berhasil Disimpan.."
    redirect_to('/postingan/index')
  end

  def edit
    # @data = Postingan.find(params[:id])
  end

  def update
    # @data = Postingan.find(params[:id])
    # @data.judul = params[:judul]
    # @data.deskripsi = params[:deskripsi]
    # @data.save
    @data.update(judul: params[:judul], deskripsi: params[:deskripsi])

    flash[:pesan] = "Data Berhasil Diubah.."
    redirect_to('/postingan/index')
  end

  def delete
    # @data = Postingan.find(params[:id])
    @data.destroy

    flash[:pesan] = "Data Berhasil Dihapus.."
    redirect_to('/postingan/index')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postingan
      @data = Postingan.find(params[:id])
    end

    def postingan_params
        # @param = judul: params[:judul], deskripsi: params[:deskripsi]
    end

end
