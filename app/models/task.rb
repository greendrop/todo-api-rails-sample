# frozen_string_literal: true

# ## Schema Information
#
# Table name: `tasks`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `bigint`           | `not null, primary key`
# **`user_id`**      | `bigint`           |
# **`title`**        | `string(255)`      |
# **`description`**  | `text(65535)`      |
# **`done`**         | `boolean`          | `default(FALSE), not null`
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_tasks_on_user_id`:
#     * **`user_id`**
#

class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
end
