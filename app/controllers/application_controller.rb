class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
#  filter_parameter_logging :password, :password_confirmation
  before_filter :add_log

  def add_log

    return if current_user.nil?

    log = ActivityLog.new

    log.session_id  = request.session_options[:id]
    log.user_id     = current_user.id
    log.browser     = request.env['HTTP_USER_AGENT']
    log.ip_address  = request.env['REMOTE_ADDR']
    log.controller  = controller_name
    log.action      = action_name
    log.request_at  = Time.now
    log.params      = remove_action_controller params
    log.url         = request.url

    log.save
#    logger.debug "uri #{request.url}"
#    logger.debug "log.starting"
#    logger.debug "log.session_id = #{request.session_options[:id]}"
#    logger.debug "log.session_id = #{Integer(request.session_options[:id])}"
#    logger.debug "log.user_id    = #{current_user.id}"
#    logger.debug "log.browser    = #{request.env['HTTP_USER_AGENT']}"
#    logger.debug "log.ip_address = #{request.env['REMOTE_ADDR']}"
#    logger.debug "log.controller = #{controller_name}"
#    logger.debug "log.action     = #{action_name}"
#    logger.debug "log.request_at = #{Time.now}"

  end

  def remove_action_controller( input_params )
#    filtered_params = input_params.inject {} do |h,(k,v)|
#     h[k] = v; h
#    end


#    filtered_params = input_params.dup
#
#    filtered_params.delete :action
#    filtered_params.delete :controller
#
#    filtered_params

    output = input_params.reject{ |key,value| key == "action" || key == "controller" }
    logger.debug "output params: #{output}"

    output
  end
end
