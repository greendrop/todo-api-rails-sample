# frozen_string_literal: true

module Api
  module V1
    class TasksController < Api::UserBaseController
      before_action :find_task, only: %i[show update destroy]

      def index
        page = params[Kaminari.config.page_method_name] || 1
        per_page = params[:per_page] || Kaminari.config.default_per_page

        @tasks = Task.ransack(params[:q])
                     .result
                     .where(user_id: current_resource_owner.id)
                     .order(:id)
                     .page(page)
                     .per(per_page)

        response.headers['Total-Count'] = index_total_count_header(@tasks)
        response.headers['Link'] = index_link_header(@tasks)

        render json: @tasks.as_json
      end

      def show
        render json: @task, serializer: TaskSerializer
      end

      def create
        @task = Task.new(task_params.merge(user_id: current_resource_owner.id))
        if @task.save
          render json: @task, serializer: Api::TaskSerializer, status: :created
        else
          serializer = Api::TaskSerializer.new(@task, with_errors: true)
          render json: serializer.serializable_hash, status: :bad_request
        end
      end

      def update
        if @task.update(task_params)
          head 204
        else
          render json: @task.as_json.merge(errors: validate_errors(@task)), status: :bad_request
        end
      end

      def destroy
        @task.destroy!
        head 204
      end

      private

      def find_task
        @task = Task.where(user_id: current_resource_owner.id).find(params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :description, :done)
      end
    end
  end
end
