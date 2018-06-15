ruby_block "Update node attributes and save them to a file" do
  block do
    node.automatic.delete('counters')
    node.automatic['memory'] = { 'total' => node.automatic['memory']['total'] }
    fs_fields = ['kb_used', 'kb_available', 'percent_used', 'inodes_used', 'inodes_available', 'inodes_percent_used']
    node.automatic['filesystem'].each do |order, order_data|
      order_data.each do |filesystem, filesystem_data|
        fs_fields.each do |field|
          if filesystem_data.has_key?(field)
            filesystem_data.delete(field)
            node.automatic['filesystem'][order][filesystem] = filesystem_data
          end
        end
      end
    end
    parent = File.join(ENV["TEMP"] || "/tmp", "kitchen")
    IO.write(File.join(parent, "chef_node.json"), node.to_json) if Dir::exist?(parent)
  end
end
