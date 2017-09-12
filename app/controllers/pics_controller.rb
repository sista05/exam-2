class PicsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :confirm, :create]
  before_action :set_pic, only: [:edit, :update, :destroy, :show]
  def index
    @pics = Pic.all
  end
  
  #def confirm
  #  @pic = Pic.new(pics_params)
  #  render :new if @pic.invalid?
  #end

  def new

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
        redirect_to pics_path, notice: "写真を投稿しました!"
        NoticeMailer.sendmail_pic(@pic).deliver
    else
        render action: 'new'
    end
  end

  def edit

  end

  def update

    if @pic.update(pics_params)
      redirect_to pics_path, notice: "写真を更新しました!"
    else
    render action: 'edit'
    end
  end

  def destroy

    @pic.destroy
    redirect_to pics_path, notice: "写真を削除しました!"
  end
  
  def show

  end

  private
  def pics_params
    params.require(:pic).permit(:title, :content, :image)
  end

  def set_pic
    @pic = Pic.find(params[:id])
  end

end
