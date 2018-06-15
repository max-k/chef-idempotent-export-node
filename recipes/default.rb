template "#{File.join(ENV["TEMP"] || '/tmp', 'kitchen')}/chef_node.json" do
    owner 'root'
    mode 0644
    variables(
        node: node
    )
end
