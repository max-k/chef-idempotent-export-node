ruby_block "Save node attributes" do
  block do
    parent = File.join(ENV["TEMP"] || "/tmp", "kitchen")
    node['network'].delete('counters')
    node['memory'] = { 'total' => node['memory']['total'] }
    node['filesystem'].each do |order, order_data|
        order.each do |filesystem, filesystem_data|
            if filesystem_data.has_key?('kb_used')
                new_fs = node['filesystem'][order][filesystem].except!('kb_used',
                                                                       'kb_available',
                                                                       'percent_used',
                                                                       'inodes_used',
                                                                       'inodes_available',
                                                                       'inodes_percent_used')
                node['filesystem'][order][filesystem] = new_fs
            end
        end
    end

    IO.write(File.join(parent, "chef_node.json"), node.to_json) if Dir::exist?(parent)
  end
end
