#ruby_block "Update node attributes and save them to a file" do
#  block do
#    node.automatic.delete('counters')
#    node.automatic['memory'] = { 'total' => node.automatic['memory']['total'] }
#    fs_fields = ['kb_used', 'kb_available', 'percent_used', 'inodes_used', 'inodes_available', 'inodes_percent_used']
#    if node.automatic['filesystem'].has_key?('by_device')
#        fs_identifier = 'filesystem'
#    else
#        fs_identifier = 'filesystem2'
#    end
#    node.automatic[fs_identifier].each do |order, order_data|
#      order_data.each do |filesystem, filesystem_data|
#        fs_fields.each do |field|
#          if filesystem_data.has_key?(field)
#            filesystem_data.delete(field)
#            node.automatic[fs_identifier][order][filesystem] = filesystem_data
#          end
#        end
#      end
#    end
#    if fs_identifier == "filesystem2"
#        node.automatic['filesystem'] = node.automatic['filesystem2']
#        node.automatic.delete('filesystem2')
#    end
#    parent = File.join(ENV["TEMP"] || "/tmp", "kitchen")
#    IO.write(File.join(parent, "chef_node.json"), node.to_json) if Dir::exist?(parent)
#  end
#end
template "#{File.join(ENV["TEMP"] || '/tmp', 'kitchen')}/chef_node.json" do
    owner 'root'
    mode 0644
    variables(
        node: node
    )
end
