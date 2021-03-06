class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :verity_auth, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
     @post_attachments = @post.post_attachments.all
  end

  # GET /posts/new
  def new
     @post = Post.new
     @post_attachment = @post.post_attachments.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
   @post = Post.new(post_params.merge(:user_id => current_user.id))

   respond_to do |format|
     if @post.save
       unless params[:post_attachments].nil?
       params[:post_attachments]['picture'].each do |a|
          @post_attachment = @post.post_attachments.create!(:picture => a, :post_id => @post.id)
        end
       end
       format.html { redirect_to @post, notice: 'Post was successfully created.' }
     else
       format.html { render action: 'new' }
     end
   end
 end
  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :pict, :user_id, post_attachments_attributes: [:id, :post_id, :picture])
    end

    def verity_auth
      if @post.user_id === current_user.id
        true
      else
        redirect_to :root, alert: "tonbouy"
      end
    end
end
