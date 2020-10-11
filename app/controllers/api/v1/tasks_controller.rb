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

        data =
          @tasks.map do |task|
            serializer = Api::TaskSerializer.new(task)
            serializer.serializable_hash
          end
        json = {
          data: data,
          paging: paging_by_kaminari(@tasks)
        }
        render json: json
      end

      def show
        serializer = Api::TaskSerializer.new(@task)
        render_success serializer.serializable_hash
      end

      def create
        @task = Task.new(task_params.merge(user_id: current_resource_owner.id))
        if @task.save
          serializer = Api::TaskSerializer.new(@task)
          render_created serializer.serializable_hash
        else
          serializer = Api::TaskSerializer.new(@task, with_errors: true)
          render_bad_request serializer.serializable_hash
        end
      end

      def update
        if @task.update(task_params)
          render_no_content
        else
          serializer = Api::TaskSerializer.new(@task, with_errors: true)
          render_bad_request serializer.serializable_hash
        end
      end

      def destroy
        @task.destroy!
        render_no_content
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
