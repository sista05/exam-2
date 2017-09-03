class PicsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :confirm, :create]
  before_action :set_pic, only: [:edit, :update, :destroy, :show]
  def index
    @pics = Pic.all
  end
  def confirm
    @pic = Pic.new(pics_params)
    render :new if @pic.invalid?
  end

  def new
    #@pic = Pic.new
    if params[:back]
      @pic = Pic.new(pics_params)
    else
      @pic = Pic.new
    end
  end

  def create
    @pic = Pic.new(pics_params)
    @pic.user_id = current_user.id
    if @pic.save
        redirect_to pics_path, notice: "ブログを作成しました!"
        NoticeMailer.sendmail_pic(@pic).deliver
    else
        render action: 'new'
    end
  end

  def edit
    #@pic = Pic.find(params[:id])
  end

  def update
    #@pic = Pic.find(params[:id])

    if @pic.update(pics_params)
      redirect_to pics_path, notice: "ブログを更新しました!"
    else
    render action: 'edit'
    end
  end

  def destroy
    #@pic = Pic.find(params[:id])
    @pic.destroy
    redirect_to pics_path, notice: "ブログを削除しました!"
  end
  
  def show

  end

  private
  def pics_params
    params.require(:pic).permit(:title, :content)
  end

  def set_pic
    @pic = Pic.find(params[:id])
  end

end
