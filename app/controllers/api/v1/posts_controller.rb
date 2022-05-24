module Api
  module V1
    class PostsController < ApplicationController
      def_param_group :post do
        param :post, Hash, required: true do
          param :title, String, desc: 'Title of post', required: true
          param :body, String, desc: 'Body of post', required: true
        end
      end

      api :GET, '/api/v1/posts'
      def index
        @posts = Post.all
        render json: @posts, status: :ok
      end

      api :POST, '/api/v1/posts'
      param_group :post
      returns :post, desc: 'A created post'
      formats [:json]

      def create
        @post = Post.new
        render json @post, status: :created
      end
    end
  end
end