module ApplicationHelper
  def flash_class(level)
    classes = {
      'notice' => 'alert alert-info',
      'success' => 'alert alert-success',
      'error' => 'alert alert-danger',
      'alert' => 'alert alert-warning'
    }
    classes[level]
  end
end
