class SlackCommandsController < ApplicationController
  def latest_incidents
    incidents = Incident.order(created_at: :desc, status: 'open').limit(5)
    incident_report = "Incident Report"

    incidents.each do |i|
      incident_report << "\n Title: #{i.title} \n Description: #{i.description} \n Severity: #{i.severity} \n Channel: <##{i.new_channel_id}|incident-#{title.downcase}>"
      incident_report << "\n"
    end

    render json: incident_report
  end
  def declare
      parts = params_text.split(' ').map(&:strip)

      title = parts[0]
      description = parts[1]
      severity = parts[2]

      response = user_oauth_response.conversations_create(name: "incident-#{title.downcase}")

      new_channel_name = response.channel.name
      new_channel_id = response.channel.id
  
      incident = Incident.create(title: title, description: description, severity: severity, status: 'open', slack_channel_id: new_channel_id)

      bot_user_oauth_response.chat_postMessage(channel: channel_id, text: "New incident declared: <##{new_channel_id}|incident-#{new_channel_name}>")
  
      render plain: "Incident declared: <##{new_channel_id}|incident-#{new_channel_name}>. A new channel has been created for this incident."
    end

  def resolve
    incident = Incident.find_by(slack_channel_id: channel_id)
  
    if channel_name.include? "incident" and incident
      incident.update(status: 'resolved', resolved_at: Time.now)
      user_oauth_response.conversations_archive(channel: channel_id)

      render plain: "Incident resolved in #{TimeDifference.between(Time.now, Incident.last.resolved_at).humanize}"
    else
      render plain: "This is not an incident channel, resolve error"
    end
  end

  def open_ticket
    incident = Incident.find_by(title: params_text)
    
    if incident.nil?
    incident = Incident.find_by(slack_channel_id: params_text) 
    end

    if incident
      incident.update(status: 'open')
      user_oauth_response.conversations_unarchive(channel: incident.slack_channel_id)

      render plain: "Incident re-opened"
    else
      render plain: "No Incident found"
    end
  end

  private def channel_name
    params.require(:channel_name)
  end

  private def channel_id
    params.require(:channel_id)
  end

  private def params_text
    params.require(:text)
  end
  
  private def user_oauth_response
    Slack::Web::Client.new(token: ENV['USER_OAUTH_TOKEN'])
  end

  private def bot_user_oauth_response
    Slack::Web::Client.new(token: ENV['BOT_USER_OAUTH_TOKEN'])
  end
end
  