def formatted_data(agent, page)
  node = agent.parse_current_date_data(page)
  extracted_data = agent.parse_selector(node)
  formatted = agent.format_parsed_selector(extracted_data)
end
